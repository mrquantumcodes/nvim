return {
	'echasnovski/mini.files',
	version = false,
	-- General options
	options = {
		-- Whether to delete permanently or move into module-specific trash
		permanent_delete = false,
		-- Whether to use for editing directories
		use_as_default_explorer = true,
	},
	config = function()
		require('mini.files').setup({})
	end,
	-- event = "VeryLazy",
	keys = {
		{ "<leader>e", "<cmd>lua MiniFiles.open(vim.fn.expand('%:h')); MiniFiles.reset()<CR>", desc = "Copilot" },
	}
}
