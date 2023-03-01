require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

local opts = { noremap = true, silent = true }
local on_attach = function(client, bufnr)
	-- LSPのフォーマットを無効
	client.server_capabilities.documentFormattingProvider = false

	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	-- -- Mappings.
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "rn", vim.lsp.buf.rename, bufopts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup{
			capabilities = capabilities, --cmpを連携⇐ココ！
			-- on_attach = on_attach, --keyバインドなどの設定を登録
		}
	end,
})

