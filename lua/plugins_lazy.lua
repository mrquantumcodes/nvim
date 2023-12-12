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
	-- { "AndrewRadev/tagalong.vim", event = "VeryLazy" },
	-- },
	-- { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", cond = false },
	-- { "tjdevries/colorbuddy.nvim",       event = "VeryLazy" },
	{ "neoclide/coc.nvim",        branch = "release", event = "VeryLazy" },
	{ "nvim-lua/plenary.nvim",    event = "BufEnter" },
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
	-- { "tpope/vim-commentary", event = "VeryLazy" },
	-- { 'HiPhish/rainbow-delimiters.nvim', event = "VeryLazy" },

	-- { 'williamboman/mason.nvim',             event = "VeryLazy" },
	-- { 'williamboman/mason-lspconfig.nvim' },
	-- { 'VonHeikemen/lsp-zero.nvim',           branch = 'v3.x',   event = "VeryLazy" },
	-- { 'neovim/nvim-lspconfig' },
	-- { 'hrsh7th/cmp-nvim-lsp',                event = "VeryLazy" },
	-- { 'hrsh7th/nvim-cmp',                    event = "VeryLazy" },
	-- { 'L3MON4D3/LuaSnip',                    event = "VeryLazy" },
	{ 'github/copilot.vim',   event = "VeryLazy" },
})
