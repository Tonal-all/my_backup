-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim")
	use("tpope/vim-unimpaired")
	use("flazz/vim-colorschemes")
	-- use('folke/which-key.nvim')
	use("sainnhe/gruvbox-material")

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
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
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
	use("lukas-reineke/cmp-under-comparator")
	use("dcampos/nvim-snippy")
	use("rafamadriz/friendly-snippets")
	use("dcampos/cmp-snippy")
	use("mfussenegger/nvim-jdtls")
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
	use("simrat39/symbols-outline.nvim")
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
			{ "kkharji/sqlite.lua", module = "sqlite" },
			-- you'll need at least one of these
			{ "nvim-telescope/telescope.nvim" },
			{ "ibhagwan/fzf-lua" },
		},
	})
	use("liuchengxu/vim-clap")
	use("p00f/nvim-ts-rainbow")
	use("simrat39/rust-tools.nvim")
	use({
		"m-demare/hlargs.nvim",
		requires = { "nvim-treesitter/nvim-treesitter" },
	})
	use("lewis6991/impatient.nvim")
	use("puremourning/vimspector")
	use("RRethy/vim-illuminate")
	use({
		"glepnir/dashboard-nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
	})
	use("norcalli/nvim-colorizer.lua")
	use({ "nguyenvukhang/nvim-toggler" })
	use({ "michaelb/sniprun", run = "bash ./install.sh" })
	use("windwp/nvim-ts-autotag")
	use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })
	use({ "kevinhwang91/nvim-hlslens" })
	use("simeji/winresizer")
	use({
		"luukvbaal/statuscol.nvim",
	})
end)
