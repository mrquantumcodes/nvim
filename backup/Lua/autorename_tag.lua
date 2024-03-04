-- change the keymap to whatever you want
vim.keymap.set("n", "<leader>ct", "", {
	noremap = true,
	silent = true,
	callback = function()
		newtag = vim.fn.input("Enter new tag name: ")
		local return_position = vim.api.nvim_win_get_cursor(0)

		vim.cmd([[execute "normal T<"]])

		-- check if the character is slash
		-- i.e. if it is a closing tag
		-- and if yes, move the cursor to the opening tag
		-- I dunno why, but it just works better when we change the opening tag first
		local col = vim.api.nvim_win_get_cursor(0)[2]
		local char = vim.api.nvim_get_current_line():sub(col + 1, col + 1)

		if char == "/" then
			vim.cmd([[execute "normal %"]])
		end

		-- store the current cursor position
		local current_position = vim.api.nvim_win_get_cursor(0)

		-- go to the closing tab and move one character to the right, so that we can change the tag name
		vim.cmd([[execute "normal %l"]])

		vim.cmd('execute "normal \\"_ciw' .. newtag .. '"')

		-- go to current_position
		vim.api.nvim_win_set_cursor(0, current_position)

		-- change this tag as well
		vim.cmd('execute "normal \\"_ciw' .. newtag .. '"')

		-- return to return_position
		vim.api.nvim_win_set_cursor(0, return_position)
	end
})
