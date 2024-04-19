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

require("lazy").setup({
	{
		"neoclide/coc.nvim",
		branch = "release",
		-- event = "VeryLazy",
		lazy = true,
		ft = { "php", "html", "css", "js", "json", "yaml", "lua", "vim", "markdown", "c", "cpp", "rust", "python", "ruby", "go", "typescript", "javascript", "scss", "sass", "less", "stylus", "graphql", },
		-- keys = {
		-- 	{ "<leader>coc", "<cmd>echo 'COC Enabled'<cr>", desc = "" },
		-- },

		-- cond = false,
	},
	{ 'echasnovski/mini.pick', version = false, config = function() require("mini.pick").setup({}) end },
	-- {'Yggdroot/LeaderF', event = "VeryLazy"},
	-- { "junegunn/fzf", dir = "~/.fzf", build = "./install --all" },
	{"mrquantumcodes/configpulse"},
	-- init.lua:
    -- {
    -- 'nvim-telescope/telescope.nvim', tag = '0.1.6',
    --   dependencies = { 'nvim-lua/plenary.nvim' }
    -- },
	{
		"mrquantumcodes/bufferchad.nvim",
		event = "VeryLazy",
		config = function()
			-- require("bufferchad/lua/bufferchad").setup({
			require("bufferchad").setup({
				mapping = "q",
				mark_mapping = "<leader>m",
				-- order = "LAST_USED_UP",
				close_mapping = "q",
				style = "normal",
			})
		end
	},
	{
		"mrquantumcodes/retrospect.nvim",
		event = "VeryLazy",
		config = function()
			retrospect = require('retrospect')
			retrospect.setup({
				style = "default"
			})
		end
	},
	{
		'github/copilot.vim',
		-- event = "VeryLazy",
		-- keys = {
		-- 	{ "<leader>cop", "<cmd>echo 'Copilot Enabled'<cr>", desc = "Copilot" },
		-- },
		ft = {
			"php", "html", "css", "js", "json", "yaml", "lua", "vim", "markdown", "c", "cpp", "rust", "python", "ruby",
			"go", "typescript", "javascript", "scss", "sass", "less", "stylus", "graphql"
		}
	},
})
