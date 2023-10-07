-- -- Define a function to open a floating terminal window
-- function OpenFloatingTerminal()
--     local cmd = "terminal" -- Command to run in the terminal window

--     -- Create the terminal buffer
--     local terminal_buffer = vim.api.nvim_create_buf(false, true)

--     -- Create the terminal window
--     local terminal_window = vim.api.nvim_open_win(terminal_buffer, true, {
--         relative = "editor",
--         width = vim.o.columns / 2,
--         height = vim.o.lines / 2,
--         row = 10,
--         col = 10,
--         style = "minimal",
--         border = "single",
--     })

--     vim.api.nvim_buf_call(terminal_buffer, function()
--         vim.cmd('terminal')
--       end)

--     -- Execute the command in the terminal window
--     -- vim.fn.termopen()

--     -- Set key mapping to close the terminal window (F7 in this case)
--     vim.api.nvim_buf_set_keymap(terminal_buffer, "n", "<F7>", "<Cmd>q<CR>", { noremap = true, silent = true })

--     -- Switch to the terminal buffer
--     vim.api.nvim_set_current_buf(terminal_buffer)
-- end

-- -- Bind the function to the F7 key
-- vim.api.nvim_set_keymap('n', '<F7>', '<Cmd>lua OpenFloatingTerminal()<CR>', { noremap = true, silent = true })


-- -- function OpenNetrw()
-- --     local bufnr = vim.api.nvim_create_buf(false, true)

-- --     -- Set the buffer contents to the list of buffer paths

-- --     -- Create a window for the buffer
-- --     local win_id = vim.api.nvim_open_win(bufnr, true, {
-- --         relative = 'editor',
-- --         width = vim.o.columns / 2,
-- --         height = vim.o.lines / 2,
-- --         row = vim.o.lines / 2 - vim.o.lines / 4,
-- --         col = vim.o.columns / 2 - vim.o.columns / 4,
-- --         style = 'minimal',
-- --         border = 'rounded',
-- --         title = 'Navigate to a Buffer',
-- --         -- anchor = 'NE'
-- --     })

-- --     vim.api.nvim_buf_call(bufnr, function()
-- --         vim.cmd('E')
-- --     end)

-- --     -- Set key mappings for navigation and buffer opening
-- --     vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Esc><Esc>', "", {
-- --         noremap = true,
-- --         silent = true,
-- --         callback = function()
-- --             vim.api.nvim_buf_call(bufnr, function()
-- --                 vim.cmd('set modifiable')
-- --             end)

-- --             vim.cmd('bdelete ' .. bufnr)
-- --         end
-- --     })
-- -- end
