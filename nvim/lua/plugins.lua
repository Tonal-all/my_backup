-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim")
	use("flazz/vim-colorschemes")

	use("MunifTanjim/nui.nvim")

	use("kana/vim-textobj-user")
	use("kana/vim-textobj-entire")
	use("kana/vim-textobj-line")
	use("kana/vim-textobj-indent")

	use("tpope/vim-sensible")
	use("tpope/vim-repeat")

	use("ggandor/leap.nvim")
	use("ggandor/flit.nvim")

	use("kylechui/nvim-surround")

	use("mg979/vim-visual-multi")
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
	})
	use("vim-airline/vim-airline")
	use("vim-airline/vim-airline-themes")
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	use("dcampos/nvim-snippy")
	use("rafamadriz/friendly-snippets")
	use("dcampos/cmp-snippy")
    use 'mfussenegger/nvim-jdtls'
	use("onsails/lspkind.nvim")
	use("windwp/nvim-autopairs")
	use({ "glepnir/lspsaga.nvim", branch = "main" })
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	-- use 'simrat39/symbols-outline.nvim'
	use({ "numToStr/Comment.nvim" })
	use({
		"nvim-telescope/telescope-frecency.nvim",
		config = function()
			require("telescope").load_extension("frecency")
		end,
		requires = { "kkharji/sqlite.lua" },
	})
	use("lukas-reineke/indent-blankline.nvim")
	use("kdheepak/lazygit.nvim")
	use("tpope/vim-fugitive")
	use("lewis6991/gitsigns.nvim")
	use({
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
	})

	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
	})
	use({
		"AckslD/nvim-neoclip.lua",
		requires = {
            {'kkharji/sqlite.lua', module = 'sqlite'},
			-- you'll need at least one of these
			-- {'nvim-telescope/telescope.nvim'},
			-- {'ibhagwan/fzf-lua'},
		},
	})
    use 'liuchengxu/vim-clap'
    use 'p00f/nvim-ts-rainbow'
end)
