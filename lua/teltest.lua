-- -- Function to create a buffer list window
-- function CreateBufferListWindow(buffer_paths)
--     -- Create a new scratch buffer
--     local bufnr = vim.api.nvim_create_buf(false, true)
    
--     -- Set the buffer contents to the list of buffer paths
--     vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, buffer_paths)
    
--     -- Create a window for the buffer
--     local win_id = vim.api.nvim_open_win(bufnr, true, {
--         relative = 'center',
--         width = 40,
--         height = #buffer_paths,
--         row = vim.o.lines / 2 - #buffer_paths / 2 - 1,
--         col = vim.o.columns / 2 - 20,
--         style = 'minimal',
--         border = 'single',
--         title = 'Buffer List',
--     })

--     -- Set key mappings for navigation and buffer opening
--     vim.api.nvim_buf_set_keymap(bufnr, 'n', '<CR>', ':lua OpenBufferFromList()<CR>', { noremap = true, silent = true })
--     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'q', ':lua CloseBufferListWindow()<CR>', { noremap = true, silent = true })
    
--     -- Store window ID and buffer number for later use
--     vim.api.nvim_buf_set_var(bufnr, 'buffer_list_win_id', win_id)
--     vim.api.nvim_buf_set_var(bufnr, 'buffer_paths', buffer_paths)
-- end

-- -- Function to open a buffer from the list
-- function OpenBufferFromList()
--     local bufnr = vim.fn.bufnr('%')
--     local line_number = vim.fn.line('.')
--     local buffer_paths = vim.api.nvim_buf_get_var(0, 'buffer_paths')
--     local selected_path = buffer_paths[line_number]

--     if selected_path then
--         vim.cmd('bdelete ' .. bufnr)  -- Close the buffer list window
--         vim.cmd('edit ' .. selected_path)
--     end
-- end

-- -- Function to close the buffer list window
-- function CloseBufferListWindow()
--     local bufnr = vim.fn.bufnr('%')
--     local win_id = vim.api.nvim_buf_get_var(bufnr, 'buffer_list_win_id')
--     if vim.api.nvim_win_is_valid(win_id) then
--         vim.api.nvim_win_close(win_id, true)
--     end
-- end

-- -- Example usage:
-- -- local buffer_paths = { 'file1.txt', 'file2.txt', 'file3.txt' }
-- -- CreateBufferListWindow(buffer_paths)
