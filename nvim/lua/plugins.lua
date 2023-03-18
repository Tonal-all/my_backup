-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])
vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("PACKER", { clear = true }),
    pattern = "plugins.lua",
    command = "source <afile> | PackerCompile",
})

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")
    use("nvim-lua/plenary.nvim")
    use("tpope/vim-unimpaired")
    use("flazz/vim-colorschemes")
    -- use({ "catppuccin/nvim", as = "catppuccin" })
    -- use('folke/which-key.nvim')
    use("sainnhe/gruvbox-material")
    use("sainnhe/edge")

    use("kana/vim-textobj-user")
    use("kana/vim-textobj-entire")
    use("kana/vim-textobj-line")
    use("kana/vim-textobj-indent")

    use("tpope/vim-sensible")
    use({
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup()
        end,
    })

    use({
        "ggandor/leap.nvim",
        config = function()
            require("config.leap")
        end,
        event = "BufRead",
        requires = {
            {
                "tpope/vim-repeat",
            },
        },
    })
    use({
        "ggandor/flit.nvim",
        requires = {
            "ggandor/leap.nvim",
        },
        config = function()
            require("config.flit")
        end,
    })

    use({
        "kylechui/nvim-surround",
        config = function()
            require("config.surround")
        end,
        after = "leap.nvim",
    })

    use({
        "mg979/vim-visual-multi",
    })
    use({
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        config = function()
            require("config.neo-tree")
        end,
        event = "CursorHold",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
    })
    use({
        "wellle/targets.vim",
        event = "BufRead",
    })
    use({
        "AndrewRadev/splitjoin.vim",
        -- NOTE: splitjoin won't work with `BufRead` event
        event = "CursorHold",
    })

    -- use("vim-airline/vim-airline")
    -- use("vim-airline/vim-airline-themes")
    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = function()
            require("config.lualine")
        end,
        event = "BufRead",
    })
    -- using packer.nvim
    use({
        "akinsho/bufferline.nvim",
        tag = "v3.*",
        requires = "nvim-tree/nvim-web-devicons",
        config = function()
            require("config.bufferline")
        end,
        event = "BufRead",
    })

    use({
        "folke/neoconf.nvim",
        config = function()
            require("config.neo_conf")
        end,
        event = "BufReadPre",
    })
    use({
        "folke/neodev.nvim",
        config = function()
            require("config.neo_dev")
        end,
        requires = {
            "neovim/nvim-lspconfig",
        },
        after = "mason-lspconfig.nvim",
    })
    use({
        {
            "williamboman/mason.nvim",
            event = "BufRead",
            config = function()
                require("config.mason")
            end,
            requires = {
                "neovim/nvim-lspconfig",
            },
        },
        {
            "williamboman/mason-lspconfig.nvim",
            config = function()
                require("config.mason_lsp")
            end,
            requires = {
                "neovim/nvim-lspconfig",
                "williamboman/mason.nvim",
                "hrsh7th/cmp-nvim-lsp",
                "SmiteshP/nvim-navic",
            },
            after = "mason.nvim",
        },
    })
    use({
        "simrat39/rust-tools.nvim",
        config = function()
            require("config.rust_tool")
        end,
        requires = {
            "SmiteshP/nvim-navic",
            "chapel-lang/mason-registry",
            "hrsh7th/cmp-nvim-lsp",
        },
        after = "mason.nvim",
    })
    use({
        "p00f/clangd_extensions.nvim",
        config = function()
            require("config.clangd_ext")
        end,
        requires = {
            "chapel-lang/mason-registry",
        },
        after = "mason.nvim",
    })
    use({
        "chapel-lang/mason-registry",
    })
    use({
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup({})
        end,
    })
    use({
        "mfussenegger/nvim-dap",
        requires = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "chapel-lang/mason-registry",
            "mfussenegger/nvim-dap-python",
            "jay-babu/mason-nvim-dap.nvim",
        },
        config = function()
            require("config.mason_nvim_dap")
        end,
        after = "mason-lspconfig.nvim",
    })
    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = {
            "jay-babu/mason-null-ls.nvim",
        },
        config = function()
            require("config.null-is_nvim")
        end,
    })
    use({
        "jbyuki/one-small-step-for-vimkind",
    })
    use({
        {
            "hrsh7th/nvim-cmp",
            event = { "InsertEnter", "CmdlineEnter" },
            config = function()
                require("config.cmp")
            end,
            requires = {
                {
                    "dcampos/cmp-snippy",
                    event = "InsertEnter",
                    requires = {
                        {
                            "rafamadriz/friendly-snippets",
                            "dcampos/nvim-snippy",
                            event = "CursorHold",
                        },
                    },
                },
                {
                    "onsails/lspkind.nvim",
                    config = function()
                        require("config.lspkind")
                    end,
                },
                {
                    "lukas-reineke/cmp-under-comparator",
                },
                {
                    "windwp/nvim-autopairs",
                    config = function()
                        require("config.autopair")
                    end,
                },
            },
        },
        { "hrsh7th/cmp-path",                    after = "nvim-cmp" },
        { "hrsh7th/cmp-buffer",                  after = "nvim-cmp" },
        { "hrsh7th/cmp-cmdline",                 after = "nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
        { "rcarriga/cmp-dap",                    after = "nvim-cmp" },
    })
    use("mfussenegger/nvim-jdtls")
    use({
        "SmiteshP/nvim-navic",
        config = function()
            require("config.navic")
        end,
    })
    use({
        "utilyre/barbecue.nvim",
        requires = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        -- after = "nvim-web-devicons", -- keep this if you're using NvChad
        config = function()
            require("config.barbecue_config")
        end,
    })
    use({
        "glepnir/lspsaga.nvim",
        branch = "main",
        requires = {
            { "nvim-tree/nvim-web-devicons" },
            --Please make sure you install markdown and markdown_inline parser
            { "nvim-treesitter/nvim-treesitter" },
        },
        config = function()
            require("config.lspsaga")
        end,
    })

    use({
        {
            "nvim-treesitter/nvim-treesitter",
            event = "BufReadPost",
            run = function()
                require("nvim-treesitter.install").update({ with_sync = true })
            end,
            config = function()
                require("config.treesitter")
            end,
        },
        { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
        { "nvim-treesitter/nvim-treesitter-refactor",    after = "nvim-treesitter" },
        { "windwp/nvim-ts-autotag",                      after = "nvim-treesitter" },
        { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" },
        { "p00f/nvim-ts-rainbow",                        after = "nvim-treesitter" },
    })
    use({
        "m-demare/hlargs.nvim",
        requires = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("config.hlargs")
        end,
        after = "nvim-treesitter",
    })
    use({
        "kevinhwang91/nvim-ufo",
        requires = "kevinhwang91/promise-async",
        config = function()
            require("config.ufo")
        end,
        after = "nvim-treesitter",
    })

    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        -- or                            , branch = '0.1.x',
        requires = { { "nvim-lua/plenary.nvim" } },
        config = function()
            require("config.telescope")
        end,
        event = "CursorHold",
    })
    use({
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
            require("telescope").load_extension("frecency")
        end,
        after = "telescope.nvim",
        requires = { "kkharji/sqlite.lua" },
    })
    use({
        "AckslD/nvim-neoclip.lua",
        requires = {
            { "kkharji/sqlite.lua",           module = "sqlite" },
            -- you'll need at least one of these
            { "nvim-telescope/telescope.nvim" },
            { "ibhagwan/fzf-lua" },
        },
        after = "telescope.nvim",
        config = function()
            require("config.neoclip")
        end,
    })
    use({
        "kdheepak/lazygit.nvim",
        config = function()
            require("config.lazygit")
        end,
        after = "telescope.nvim",
    })
    use({
        "tpope/vim-fugitive",
        config = function()
            require("config.git")
        end,
        event = "CursorHold",
    })
    use({
        "lewis6991/gitsigns.nvim",
        config = function()
            require("config.gitsign")
        end,
        event = "BufRead",
    })

    use({
        "simrat39/symbols-outline.nvim",
        event = "CursorHold",
        config = function()
            require("config.symbols-outline")
        end,
    })
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("config.comment_nvim")
        end,
        event = "BufRead",
    })
    use({
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("config.indentline")
        end,
        event = "BufRead",
    })
    use({
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
        config = function()
            require("config.trouble")
        end,
        event = "CursorHold",
    })

    use({
        "akinsho/toggleterm.nvim",
        tag = "*",
        config = function()
            require("config.toggleterm")
        end,
    })
    -- use("liuchengxu/vim-clap")
    use("lewis6991/impatient.nvim")
    -- use("puremourning/vimspector")
    use("RRethy/vim-illuminate")
    use({
        "goolord/alpha-nvim",
        config = function()
            require("config.alpha")
        end,
    })
    -- use({
    --     "glepnir/dashboard-nvim",
    --     event = "VimEnter",
    --     requires = { "nvim-tree/nvim-web-devicons" },
    --     config=function ()
    --         require("config.dashboard")
    --     end
    -- })
    use({
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("config.colorize")
        end,
        event = "CursorHold",
    })
    use({
        "nguyenvukhang/nvim-toggler",
        config = function()
            require("config.nvim-toggler")
        end,
        event = "CursorHold",
    })


    use({
        "michaelb/sniprun",
        run = "bash ./install.sh",
        config = function()
            require("config.runsnip")
        end,
        event = "CursorHold",
    })
        use({
            "stevearc/overseer.nvim",
            config = function()
                require("overseer").setup()
            end,
        })


    use({
        "kevinhwang91/nvim-hlslens",
        config = function()
            require("config.hlslens")
        end,
        event = "CursorHold",
    })
    use("simeji/winresizer")
    use({
        "luukvbaal/statuscol.nvim",
        config = function()
            require("config.statuscol")
        end,
        event = "BufRead",
    })
    use("dstein64/vim-startuptime")
    use("famiu/bufdelete.nvim")
    use({
        "ThePrimeagen/harpoon",
    })
end)
