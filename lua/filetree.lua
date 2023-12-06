function filetree(fname)
	local bufnr = vim.api.nvim_create_buf(false, true)

	-- extract directory name from current file

	filename = fname or vim.api.nvim_buf_get_name(0)

	if filename == '' or filename == nil then
		filename = vim.fn.getcwd()
	end

	dirname = vim.fn.fnamemodify(filename, ':p:h'):gsub('\\', '/')
	-- print(dirname)

	buffer_names = vim.split(vim.fn.glob(dirname .. "/*"), '\n', { trimempty = true })
	-- print(buffer_names)

	-- Set the buffer contents to the list of buffer paths
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, buffer_names)

	title = "File Browser"

	-- Create a window for the buffer
	local win_id = vim.api.nvim_open_win(bufnr, true, {
		relative = 'win',
		width = 120,
		height = 25,
		row = vim.o.lines / 2 - #buffer_names / 2 - 1,
		col = vim.o.columns / 2 - 27.5,
		style = 'minimal',
		border = 'rounded',
		title = title,
		anchor = 'NW'
	})

	vim.api.nvim_buf_call(bufnr, function()
		vim.cmd('set nomodifiable')
	end)

	-- Set key mappings for navigation and buffer opening
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<CR>', "", {
		noremap = true,
		silent = true,
		callback = function()
			local bufnr = vim.fn.bufnr('%')
			local line_number = vim.fn.line('.')
			local selected_path = buffer_names[line_number]

			vim.api.nvim_buf_call(bufnr, function()
				vim.cmd('set modifiable')
			end)

			vim.cmd('bdelete ' .. bufnr) -- Close the buffer list window
			-- vim.cmd('edit ' .. selected_path)

			if selected_path then
				if not vim.fn.isdirectory(selected_path) then
					vim.cmd('e ' .. selected_path)
				else
					filetree(selected_path)
				end
			end
		end
	})

	-- Set key mappings for navigation and buffer opening
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Esc><Esc>', "", {
		noremap = true,
		silent = true,
		callback = function()
			vim.api.nvim_buf_call(bufnr, function()
				vim.cmd('set modifiable')
			end)

			vim.cmd('bdelete ' .. bufnr)
		end
	})

	-- Store window ID and buffer number for later use
	vim.api.nvim_buf_set_var(bufnr, 'buffer_list_win_id', win_id)
end
