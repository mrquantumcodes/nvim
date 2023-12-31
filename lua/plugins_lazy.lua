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
		event = "VeryLazy",
		-- cond = false,
	},
	{ "ctrlpvim/ctrlp.vim" },
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
	{ 'github/copilot.vim', event = "VeryLazy" },
})
