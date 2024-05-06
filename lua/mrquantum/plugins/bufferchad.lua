return {
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
}
