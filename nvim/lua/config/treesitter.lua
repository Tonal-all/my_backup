require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"vim",
		"dockerfile",
		"typescript",
		"javascript",
		"json",
		"lua",
		"gitignore",
		"bash",
		"markdown",
		"markdown_inline",
		"css",
		"scss",
		"yaml",
		"toml",
		"vue",
		"php",
		"html",
		"maintained",
	},
	-- ignore_install = { "html" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false, -- catpuucin用
		disable = {},
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			node_incremental = "<CR>",
			node_decremental = "<BS>",
			scope_incremental = "<TAB>",
		},
	},
	indent = {
		enable = true,
		disable = { "html" },
	},
	autotag = {
		enable = true,
	},
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
})
