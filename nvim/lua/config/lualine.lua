--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
    return function(str)
        local win_width = vim.fn.winwidth(0)
        if hide_width and win_width < hide_width then
            return ""
        elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
            return str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
        end
        return str
    end
end
local function keymap()
    if vim.opt.iminsert:get() > 0 and vim.b.keymap_name then
        return "⌨ " .. vim.b.keymap_name
    end
    return ""
end
local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
        }
    end
end
local function window()
    return vim.api.nvim_win_get_number(0)
end

require("lualine").setup({
    options = {
        theme = "edge",
    },
    sections = {
        lualine_a = {
            { "mode", fmt = trunc(80, 4, nil, true) },
            {
                function()
                    return require("lsp-status").status()
                end,
                fmt = trunc(120, 20, 60),
            },
        },
        lualine_b = { { "b:gitsigns_head", icon = "" }, { "diff", source = diff_source }, "diagnostics" },
        lualine_c = { { "filename", fmt = trunc(90, 30, 50) } },
        lualine_y = { "progress" ,keymap},
    },
})
