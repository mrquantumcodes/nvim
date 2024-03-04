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
	-- {
	-- 	"nvim-treesitter/nvim-treesitter",
	-- 	build = ":TSUpdate",
	-- 	cond = false
	-- },
	-- {'folke/tokyonight.nvim'},
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
	-- {
	-- 	"sheerun/vim-polyglot",
	-- 	lazy = true,
	-- 	keys = {
	-- 		{ "<leader>pl", "<cmd>echo 'Polyglot Enabled'<CR><cmd>syntax on<CR>", desc = "" },
	-- 	},
	-- 	-- cond = false
	-- },
	-- { "junegunn/fzf", dir = "~/.fzf", build = "./install --all" },
	{'Yggdroot/LeaderF', event = "VeryLazy"},
	-- {
	-- 	"ibhagwan/fzf-lua",
	-- 	-- optional for icon support
	-- 	-- dependencies = { "nvim-tree/nvim-web-devicons" },
	-- 	-- event = "VeryLazy",
	-- 	lazy = true,
	-- 	ft = { "php", "html", "css", "js", "json", "yaml", "lua", "vim", "markdown", "c", "cpp", "rust", "python", "ruby", "go", "typescript", "javascript", "scss", "sass", "less", "stylus", "graphql", },
	-- 	config = function()
	-- 		-- calling `setup` is optional for customization
	-- 		-- require("fzf-lua").setup({
	-- 		-- 	cmd = "rg --files",
	-- 		-- 	-- winopts = { preview = { hidden = "hidden" } },
	-- 		-- 	-- fzf_opts = {['--layout'] = 'reverse-list'},
	-- 		-- })
	-- 		require("fzf-lua").setup({
	-- 		})
	-- 	end
	-- },
	-- {
	-- 	"ctrlpvim/ctrlp.vim",
	-- 	keys = {
	-- 		{ "<leader>f", "<cmd>CtrlP<cr>", desc = "" },
	-- 	},
	-- 	config = function()
	-- 		vim.cmd([[
	-- 			let g:ctrlp_by_filename = 1
	-- 		]])
	-- 		-- vim.cmd([[
	-- 		-- 	let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard']
	-- 		-- ]])
	-- 		-- vim.cmd([[
	-- 		-- let g:ctrlp_user_command = ['ag', '%s -l --nocolor -g ""']
	-- 		-- ]])
	-- 		-- vim.cmd("let g:ctrlp_user_command = 'rg --files %s --color=never --glob \"\"'")
	-- 		-- vim.cmd("let g:ctrlp_user_command = 'fd --type f --color=never \"\" %s'")
	-- 		vim.cmd("let g:ctrlp_user_command = 'fd --type f --color=never \"\" %s'")
	-- 		vim.cmd("let g:ctrlp_use_caching = 1")
	-- 	end
	-- },
	-- { "nvim-lua/plenary.nvim", event = "BufEnter" },
	-- {
	-- 	"nvim-telescope/telescope.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require('telescope').setup({
	-- 			defaults = {
	-- 				file_ignore_patterns = { -- List of folders/files to exclude
	-- 					'**/node_modules/**',
	-- 					'**build/**',
	-- 					'**to_ignore/**',
	-- 					'**images/**',
	-- 					'vendor/*',
	-- 					'.jpg',
	-- 					'.jpeg',
	-- 					'.png',
	-- 					'.gif',
	-- 					'.avif',
	-- 					'.tiff',
	-- 					'.webp',
	-- 				}
	-- 			},
	-- 		})
	-- 	end
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
				style = "default",
			})
		end
	},
	-- { "junegunn/fzf", build = "fzf:install()" },
	{
		"mrquantumcodes/retrospect.nvim",
		event = "VeryLazy",
		config = function()
			retrospect = require('retrospect')
			retrospect.setup({
				style = "modern"
			})
		end
	},
	{
		'github/copilot.vim',
		-- event = "VeryLazy",
		keys = {
			{ "<leader>cop", "<cmd>echo 'Copilot Enabled'<cr>", desc = "Copilot" },
		},
	},
})
