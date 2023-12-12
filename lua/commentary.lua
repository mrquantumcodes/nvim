commentStrings = {
	{ "php",  "/*",   "*/" },
	{ "html", "<!--", "-->" },
	{ "css",  "/*",   "*/" },
	{ "js",   "/*",   "*/" },
	{ "lua",  "--[[", "]]" },
	{ "c",    "/*",   "*/" },
	{ "cpp",  "/*",   "*/" },
	{ "java", "/*",   "*/" },
	{ "py",   "'''",  "'''" },
	{ "sh",   "#",    "#" },
	{ "vim",  "\"",   "\"" },
	{ "vim",  "\"",   "\"" },
}

-- get comment string for filetype
function getCommentString(filetype)
	for _, commentString in ipairs(commentStrings) do
		if commentString[1] == filetype then
			-- return commentString[2], commentString[3]
			return commentString
		end
	end
	return nil
end

-- get selected text and comment each line separately
function comment()
end

filetype = vim.bo.filetype
commentString = getCommentString(filetype)

-- set autocommand for buffer change
vim.cmd("autocmd BufEnter * lua commentString = getCommentString(filetype)")

-- get selected text and uncomment each line separately
function uncomment()
	local filetype = vim.bo.filetype
	local commentString = getCommentString(filetype)
	local startLine, endLine = getStartAndEndLine()
	local lines = getLines(startLine, endLine)
	local uncommentedLines = uncommentLines(lines, commentString)
	replaceLines(startLine, endLine, uncommentedLines)
end

-- set keymaps
-- vim.api.nvim_set_keymap('n', '<leader>c', ':lua comment()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<leader>c', "", { noremap = true, silent = true, callback = function ()
	-- go to each line in selection and comment it

	vim.cmd("<Esc>xi" .. getCommentString(vim.bo.filetype)[2] .. "<Esc>" .. "p" .. getCommentString(vim.bo.filetype)[3] .. "<Esc>")
end })
