function pUndo()
	local neovim_data_path = vim.fn.stdpath('data')

	local udirpath = neovim_data_path:gsub("\\", "/") .. "/undodir"

	print(udirpath)

	local session_dir_exists = vim.fn.isdirectory(udirpath)
	if session_dir_exists == 0 then
		vim.fn.mkdir(udirpath, "p")
	end

	vim.cmd('set undofile')
	vim.cmd('set undodir=' .. udirpath)
	vim.cmd('set undolevels=100')
	vim.cmd('set undoreload=1000')
end

vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
	-- group = 'persistent_undo',
	callback = function()
		pUndo()
	end,
})
