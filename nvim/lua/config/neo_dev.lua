require("neodev").setup({
    -- add any options here, or leave empty to use the default settings
    library = { plugins = { "nvim-treesitter", "telescope.nvim", "nvim-dap-ui" }, types = true },
})

-- then setup your lsp server as usual
local lspconfig = require("lspconfig")

-- example to setup lua_ls and enable call snippets
lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace",
            },
        },
    },
})
