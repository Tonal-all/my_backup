local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<c-j>"] = actions.move_selection_next,
				["<c-k>"] = actions.move_selection_previous,
			},
		},
	},
	pickers = {
		colorscheme = {
            enable_preview = true,
		},
		buffers = {
			mappings = {
				i = {
					["<c-d>"] = actions.delete_buffer + actions.move_to_top,
				},
				n = {
					["d"] = actions.delete_buffer + actions.move_to_top,
				},
			},
		},
	},
})
require('telescope').load_extension('dap')
vim.keymap.set("n", "<c-f>", function()
	builtin.find_files({
		no_ignore = false,
		hidden = true,
	})
end)

vim.keymap.set("n", "<leader>l", function()
	builtin.live_grep({
		hidden = true,
	})
end)

vim.keymap.set("n", "<M-f>", "<cmd>Telescope oldfiles<cr>")
--vim.keymap.set('n', ',a', function()
--    builtin.diagnostics()
--end)
--
--vim.keymap.set("n", "<leader>l", "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>", {
--    noremap = true,
--    silent = true
--})
