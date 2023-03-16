vim.keymap.set("n", "<Space>f", function()
    vim.lsp.buf.format({ async = true })
end)

local opts = { noremap = true, silent = true }
local navic = require("nvim-navic")

local function on_attach(client, bufnr)
    navic.attach(client, bufnr)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
    function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup({
            capabilities = capabilities, --cmpを連携⇐ココ！
            on_attach = on_attach,
        })
    end,
    ["rust_analyzer"] = function()
    end,
})
