local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.diagnostics.eslint.with({
			prefer_local = "node_modules/.bin",
		}),
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.beautysh,
		null_ls.builtins.formatting.cmake_format,
		null_ls.builtins.formatting.gofumpt,
		null_ls.builtins.formatting.ktlint,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.nginx_beautifier,
		null_ls.builtins.formatting.perlimports,
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.xmlformat,
	},
	debug = false,
	on_attach = function(client)
		if client.server_capabilities.document_formatting then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		end
	end,
})
vim.keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format({ async = true })
end)
