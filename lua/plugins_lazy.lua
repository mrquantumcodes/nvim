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
	-- { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", cond = false },
	{ "neoclide/coc.nvim",     branch = "release", event = "VeryLazy" },
	{ "nvim-lua/plenary.nvim", event = "BufEnter" },
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		config = function()
			require('telescope').setup({
				defaults = {
					file_ignore_patterns = { -- List of folders/files to exclude
						'**/node_modules/**',
						'**build/**',
						'**to_ignore/**',
						'**images/**',
						'.jpg',
						'.jpeg',
						'.png',
						'.gif',
						'.avif',
						'.tiff',
						'.webp',
					}
				},
			})
		end
	},
	{
		"mrquantumcodes/bufferchad.nvim",
		event = "VeryLazy",
		config = function()
			-- require("bufferchad/lua/bufferchad").setup({
			require("bufferchad").setup({
				-- mapping = "<leader>bb",
				-- mark_mapping = "<leader>bm",
				-- order = "LAST_USED_UP",
				style = "telescope",
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
	{ 'github/copilot.vim',     event = "VeryLazy" },
	-- { "williamboman/mason.nvim", config = function ()
	-- 	require("mason").setup()
	-- end }
})
