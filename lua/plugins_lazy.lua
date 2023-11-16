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

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
	{ "folke/tokyonight.nvim" },
	-- { "rose-pine/neovim" },
	-- { "kemiller/vim-ir_black" },
	-- { "rstacruz/vim-closer",  cond = false, event = "VeryLazy" }, -- disable closer
	-- {
	-- 	"tpope/vim-dispatch",
	-- 	opt = true,
	-- 	cmd = { "Dispatch", "Make", "Focus", "Start" },
	-- 	event =
	-- 	"VeryLazy"
	-- },
	-- { "andymass/vim-matchup",            event = "VeryLazy" },
	-- {
	-- 	"w0rp/ale",
	-- 	ft = { "sh", "zsh", "bash", "c", "cpp", "cmake", "html", "markdown", "racket", "vim", "tex" },
	-- 	cmd = "ALEEnable",
	-- 	config = function()
	-- 		vim.cmd [[ALEEnable]]
	-- 	end
	-- },
	-- { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", event = "VeryLazy" },
	-- { "tjdevries/colorbuddy.nvim",       event = "VeryLazy" },
	{ "neoclide/coc.nvim",               branch = "release", event = "VeryLazy" },
	{ "nvim-lua/plenary.nvim",           event = "VeryLazy" },
	{ "nvim-telescope/telescope.nvim",   event = "VeryLazy" },
	-- { "mbbill/undotree",                 event = "VeryLazy" },
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"nvim-telescope/telescope.nvim", -- optional
		},
		config = true
	},
	-- { "tpope/vim-surround",              event = "VeryLazy" },
	{ "AndrewRadev/tagalong.vim", event = "VeryLazy" },
	-- {
	-- 	"nvim-neo-tree/neo-tree.nvim",
	-- 	branch = "v3.x",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
	-- 		"MunifTanjim/nui.nvim",
	-- 	},
	-- 	event = "VeryLazy",
	-- },
	-- { "stevearc/dressing.nvim" },
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup {
				size = 20,
				open_mapping = [[<F7>]],
				shade_terminals = false,
				persist_size = true,
				direction = "float",
				shell = "pwsh",
			}
		end,
		event = "VeryLazy"
	},
	-- { "cohama/lexima.vim",                   event = "VeryLazy" }, -- auto close brackets, etc.
	-- { "Yggdroot/indentLine",              event = "VeryLazy" }, -- see indentation
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl",      opts = {},         event = "VeryLazy" },
	{ "tpope/vim-commentary",                event = "VeryLazy" },
	{ "mrquantumcodes/bufferchad.nvim" },
	{ "mrquantumcodes/retrospect.nvim" },

	-- { 'williamboman/mason.nvim',             event = "VeryLazy" },
	-- { 'williamboman/mason-lspconfig.nvim' },
	-- { 'VonHeikemen/lsp-zero.nvim',           branch = 'v3.x',   event = "VeryLazy" },
	-- { 'neovim/nvim-lspconfig' },
	-- { 'hrsh7th/cmp-nvim-lsp',                event = "VeryLazy" },
	-- { 'hrsh7th/nvim-cmp',                    event = "VeryLazy" },
	-- { 'L3MON4D3/LuaSnip',                    event = "VeryLazy" },
	{ 'github/copilot.vim',                  event = "VeryLazy" },
	-- {
	-- 	'karb94/neoscroll.nvim',
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require('neoscroll').setup()
	-- 	end
	-- }
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	cmd = "Copilot",
	-- 	event = "InsertEnter",
	-- 	config = function()
	-- 		require("copilot").setup({})
	-- 	end,
	-- },
	-- {
	-- 	"zbirenbaum/copilot-cmp",
	-- 	config = function()
	-- 		require("copilot_cmp").setup()
	-- 	end
	-- }
})
