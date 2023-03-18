local dap = require("dap")
local dapui = require("dapui")
local sign = vim.fn.sign_define
-- These are to override the default highlight groups for catppuccin (see https://github.com/catppuccin/nvim/#special-integrations)
sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

local mason_registry = require("mason-registry")
local cpp_dap_executable = mason_registry.get_package("cpptools"):get_install_path()
    .. "/extension/debugAdapters/bin/OpenDebugAD7"

dap.adapters.cpp = {
    id = "cppdbg",
    type = "executable",
    command = cpp_dap_executable,
}
local codelldb_root = mason_registry.get_package("codelldb"):get_install_path() .. "/extension/"
local codelldb_path = codelldb_root .. "adapter/codelldb"
local liblldb_path = codelldb_root .. "lldb/lib/liblldb.so"

dap.adapters.rust = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
dap.adapters.lldb = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)

local get_args = function()
    -- 获取输入命令行参数
    local cmd_args = vim.fn.input("CommandLine Args:")
    local params = {}
    -- 定义分隔符(%s在lua内表示任何空白符号)
    local sep = "%s"
    for param in string.gmatch(cmd_args, "[^%s]+") do
        table.insert(params, param)
    end
    return params
end
local function get_executable_from_cmake(path)
    -- 使用awk获取CMakeLists.txt文件内要生成的可执行文件的名字
    -- 有需求可以自己改成别的
    local get_executable =
        'awk "BEGIN {IGNORECASE=1} /add_executable\\s*\\([^)]+\\)/ {match(\\$0, /\\(([^\\)]+)\\)/,m);match(m[1], /([A-Za-z_]+)/, n);printf(\\"%s\\", n[1]);}" '
        .. path
        .. "CMakeLists.txt"
    return vim.fn.system(get_executable)
end
dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "lldb",
        request = "launch",
        program = function()
            local current_path = vim.fn.getcwd() .. "/"
            -- 使用find命令找到Makefile或者makefile
            local fd_make = string.format("find %s -maxdepth 1 -name [m\\|M]akefile", current_path)
            local fd_make_result = vim.fn.system(fd_make)
            if fd_make_result ~= "" then
                local mkf = vim.fn.system(fd_make)
                -- 使用awk默认提取Makefile(makefile)中第一个的将要生成的可执行文件名称
                -- 有需求可以自己改成别的
                local cmd = 'awk "\\$0 ~ /:/ { match(\\$1, \\"([A-Za-z_]+)\\", m); printf(\\"%s\\", m[1]); exit; }" '
                    .. mkf
                local exe = vim.fn.system(cmd)
                -- 执行make命令
                -- Makefile里面需要设置CXXFLAGS变量哦~
                if os.execute('make CXXFLAGS="-g"') then
                    return current_path .. exe
                end
            end
            -- 查找CMakeLists.txt文件
            local fd_cmake = string.format("find %s -name CMakeLists.txt -type f", current_path)
            local fd_cmake_result = vim.fn.system(fd_cmake)
            if fd_cmake_result == "" then
                return vim.fn.input("Path to executable: ", current_path, "file")
            end
            -- 查找build文件夹
            local fd_build = string.format("find %s -name build -type d", current_path)
            local fd_build_result = vim.fn.system(fd_build)
            if fd_build_result == "" then
                -- 不存在则创建build文件夹
                if not os.execute(string.format("mkdir -p %sbuild", current_path)) then
                    return vim.fn.input("Path to executable: ", current_path, "file")
                end
            end
            local cmd = "cd " .. current_path .. "build && cmake .. -DCMAKE_BUILD_TYPE=Debug"
            -- 开始构建项目
            print("Building The Project...")
            vim.fn.system(cmd)
            local exec = get_executable_from_cmake(current_path)
            local make = "cd " .. current_path .. "build && make"
            local res = vim.fn.system(make)
            if exec == "" or res == "" then
                return vim.fn.input("Path to executable: ", current_path, "file")
            end
            return current_path .. "build/" .. exec
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = get_args,
    },
}
dap.configurations.c = dap.configurations.cpp

dap.configurations.rust = {
    {
        name = "Launch Debug",
        type = "lldb",
        request = "launch",
        program = function()
            local metadata_json = vim.fn.system("cargo metadata --format-version 1 --no-deps")
            local metadata = vim.fn.json_decode(metadata_json)
            local target_name = metadata.packages[1].targets[1].name
            local target_dir = metadata.target_directory
            return target_dir .. "/debug/" .. target_name
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        initCommand = {},
        args = function()
            -- 同样的进行命令行参数指定
            local inputstr = vim.fn.input("CommandLine Args:", "")
            local params = {}
            for param in string.gmatch(inputstr, "[^%s]+") do
                table.insert(params, param)
            end
            return params
        end,
        runInTerminal = false,
    },
}
-- To use the venv for debugpy that is installed with mason, obtain the path and pass it to `setup` as shown below.
-- I don't think this is the best idea right now, because it requires that the user installs the packages into a venv that they didn't create and may not know of.

-- local debugpy_root =   mason_registry.get_package("debugpy"):get_install_path()
require("dap-python").setup( --[[ debugpy_root.. "/venv/bin/python" --]])
require("dap-python").test_runner = "pytest"
dap.adapters.go = function(callback, _)
    local stdout = vim.loop.new_pipe(false)
    local handle
    local pid_or_err
    local port = 38697
    local opts = {
        stdio = { nil, stdout },
        args = { "dap", "-l", "127.0.0.1:" .. port },
        detached = true,
    }
    handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
        stdout:close()
        handle:close()
        if code ~= 0 then
            print("dlv exited with code", code)
        end
    end)
    assert(handle, "Error running dlv: " .. tostring(pid_or_err))
    stdout:read_start(function(err, chunk)
        assert(not err, err)
        if chunk then
            vim.schedule(function()
                require("dap.repl").append(chunk)
            end)
        end
    end)
    vim.defer_fn(function()
        callback({ type = "server", host = "127.0.0.1", port = port })
    end, 100)
end

-- 此处获取命令行输入参数，其他语言的配置也是可以加的啦
-- 主要是这个程序是一个简单的容器实验，模仿实现docker所以需要从命令行输入参数
local get_args = function()
    -- 获取输入命令行参数
    local cmd_args = vim.fn.input("CommandLine Args:")
    local params = {}
    -- 定义分隔符(%s在lua内表示任何空白符号)
    for param in string.gmatch(cmd_args, "[^%s]+") do
        table.insert(params, param)
    end
    return params
end
dap.configurations.go = {
    -- 普通文件的debug
    {
        type = "go",
        name = "Debug",
        request = "launch",
        args = get_args,
        program = "${file}",
    },
    -- 测试文件的debug
    {
        type = "go",
        name = "Debug test", -- configuration for debugging test files
        request = "launch",
        args = get_args,
        mode = "test",
        program = "${file}",
    },
}

dap.configurations.lua = {
    {
        type = "nlua",
        request = "attach",
        name = "Attach to running Neovim instance",
    },
}

dap.adapters.nlua = function(callback, config)
    callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
end

local nodedb = mason_registry.get_package("js-debug-adapter"):get_install_path()

local exclude = { "codelldb", "cppdbg", "python", "chrome" }

require("mason-nvim-dap").setup({
    automatic_setup = true,
})
require("mason-nvim-dap").setup_handlers({
    function(source_name)
        -- all sources with no handler get passed here

        for _, value in ipairs(exclude) do
            if source_name == value then
                return
            end
        end

        -- Keep original functionality of `automatic_setup = true`
        require("mason-nvim-dap.automatic_setup")(source_name)
    end,
})

dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

require("nvim-dap-virtual-text").setup({
    enabled = true, -- enable this plugin (the default)
    enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = true, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true, -- show stop reason when stopped for exceptions
    commented = false, -- prefix virtual text with comment string
    only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
    all_references = true, -- show virtual text on all all references of the variable (not only definitions)
    --- A callback that determines how a variable is displayed or whether it should be omitted
    --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
    --- @param buf number
    --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
    --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
    --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
    display_callback = function(variable, _buf, _stackframe, _node)
        return " " .. variable.name .. " = " .. variable.value .. " "
    end,
    -- experimental features:
    virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
    all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
    -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
})
dapui.setup({
    icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    -- Expand lines larger than the window
    -- Requires >= 0.7
    expand_lines = vim.fn.has("nvim-0.7") == 1,
    -- Layouts define sections of the screen to place windows.
    -- The position can be "left", "right", "top" or "bottom".
    -- The size specifies the height/width depending on position. It can be an Int
    -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
    -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
    -- Elements are the elements shown in the layout (in order).
    -- Layouts are opened in order so that earlier layouts take priority in window sizing.
    layouts = {
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                "breakpoints",
                "stacks",
                "watches",
                { id = "scopes", size = 0.25 },
            },
            size = 40, -- 40 columns
            position = "left",
        },
        {
            elements = {
                "repl",
                "console",
            },
            size = 0.25, -- 25% of total lines
            position = "bottom",
        },
    },
    controls = {
        -- Requires Neovim nightly (or 0.8 when released)
        enabled = true,
        -- Display controls in this element
        element = "repl",
        icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "↻",
            terminate = "□",
        },
    },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
    },
})
vim.keymap.set("n", "<F7>", function()
    require("dap").continue()
end)
vim.keymap.set("n", "<F11>", function()
    require("dap").step_over()
end)
vim.keymap.set("n", "<F9>", function()
    require("dap").step_into()
end)
vim.keymap.set("n", "<F10>", function()
    require("dap").step_out()
end)
vim.keymap.set("n", "<F8>", function()
    require("dap").toggle_breakpoint()
end)
vim.keymap.set("n", "<Leader>B", function()
    require("dap").set_breakpoint()
end)
vim.keymap.set("n", "<Leader>dr", function()
    require("dap").repl.open()
end)
vim.keymap.set("n", "<Leader>dl", function()
    require("dap").run_last()
end)
vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
    require("dap.ui.widgets").hover()
end)
vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
    require("dap.ui.widgets").preview()
end)
vim.keymap.set("n", "<Leader>df", function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.frames)
end)
vim.keymap.set("n", "<Leader>ds", function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.scopes)
end)
