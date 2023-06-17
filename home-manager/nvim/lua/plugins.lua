-- Bootstrap lazy.nvim --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Ze plugins --
local plugins = {
    "ellisonleao/gruvbox.nvim",
    { "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim"
        }
    },
    { 'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },
    { 'iamcco/markdown-preview.nvim',
        ft = 'markdown',
        build = function() vim.fn["mkdp#util#install"]() end,
    },

    -- "tpope/vim-commentary",
    "github/copilot.vim",
    "nvim-lualine/lualine.nvim",
    { "SmiteshP/nvim-navic",
        dependencies = {
            "neovim/nvim-lspconfig"
        }
    },

     -- git --
    "tpope/vim-fugitive",
    "lewis6991/gitsigns.nvim",

    -- lsp --
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",

    -- cmp --
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",

    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",

    -- treesitter --
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/nvim-treesitter-context",
	-- "windwp/nvim-ts-autotag",
    "nvim-treesitter/nvim-treesitter-refactor",

    -- Debugging --
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",

}

local opts = {}

require("lazy").setup({plugins, opts})
