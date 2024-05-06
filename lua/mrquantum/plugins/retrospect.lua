return {
	"mrquantumcodes/retrospect.nvim",
	event = "VeryLazy",
	config = function()
		retrospect = require('retrospect')
		retrospect.setup({
			style = "default"
		})
	end
}
