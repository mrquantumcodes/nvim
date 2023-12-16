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

vim.keymap.set('v', '<leader>c', '', { silent = true, noremap = true, callback = function()
	comment = vim.api.nvim_eval('&commentstring'):gsub('%%s', ' ')
	print(comment)
	-- split comment into start and end by space
	commentStart = ""
	commentEnd = ""

	if string.find(comment, " ") then
		commentStart = string.sub(comment, 0, string.find(comment, " ") - 1)
		commentEnd = string.sub(comment, string.find(comment, " ") + 1)
	else
		commentStart = comment
		commentEnd = ""
	end

	-- print(commentStart)
	-- print(commentEnd)

	-- loop through all selected lines and comment them
	for _, line in ipairs(vim.api.nvim_buf_get_lines(0, vim.fn.line("'<") - 1, vim.fn.line("'>"), false)) do
		-- check if line is already commented
		-- if string.find(line, commentStart) then
		-- 	-- remove comment
		-- 	vim.api.nvim_buf_set_lines(0, vim.fn.line("'<") - 1, vim.fn.line("'>"), false, { string.gsub(line, commentStart, "") })
		-- else
		-- 	-- add comment
		-- 	vim.api.nvim_buf_set_lines(0, vim.fn.line("'<") - 1, vim.fn.line("'>"), false, { commentStart .. line })
		-- end
		-- print(line)
	end
end })