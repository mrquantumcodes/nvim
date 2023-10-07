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
	{ "rstacruz/vim-closer",          cond = false }, -- disable closer
	{ "tpope/vim-dispatch",           opt = true,        cmd = { "Dispatch", "Make", "Focus", "Start" } },
	{ "andymass/vim-matchup",         event = "VimEnter" },
	-- {
	-- 	"w0rp/ale",
	-- 	ft = { "sh", "zsh", "bash", "c", "cpp", "cmake", "html", "markdown", "racket", "vim", "tex" },
	-- 	cmd = "ALEEnable",
	-- 	config = function()
	-- 		vim.cmd [[ALEEnable]]
	-- 	end
	-- },
	{ "neoclide/coc.nvim",            branch = "release" },
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-telescope/telescope.nvim" },
	{ "mbbill/undotree" },
	{ "tpope/vim-fugitive" },
	{ "tpope/vim-surround" },
	{ "AndrewRadev/tagalong.vim" },
	-- {
	-- 	"preservim/nerdtree",
	-- 	requires = {
	-- 		"ryanoasis/vim-devicons", -- optional
	-- 	},
	-- },
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{ "<leader>ee", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
		},
		config = function()
			require("neo-tree").setup({
				-- position="float"
			})
		end,

	},
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup {
				size = 20,
				open_mapping = [[<F7>]],
				shade_terminals = false,
				persist_size = true,
				direction = "float",
			}
		end
	},
	{ "cohama/lexima.vim" }, -- auto close brackets, etc.
	{ "Yggdroot/indentLine" }, -- see indentation
	--   { "MunifTanjim/nui.nvim" },
	--   {"stevearc/dressing.nvim"},
	{ "tpope/vim-commentary" },
	{ "mrquantumcodes/bufferchad.nvim" },
	{ "mrquantumcodes/retrospect.nvim" },
})
