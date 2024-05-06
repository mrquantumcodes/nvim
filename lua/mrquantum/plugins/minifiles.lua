return {
	'echasnovski/mini.files',
	version = false,
	config = function()
		require('mini.files').setup({})
	end,
	-- event = "VeryLazy",
	keys = {
		{ "<leader>e", "<cmd>lua MiniFiles.open()<CR>", desc = "Copilot" },
	}
}
