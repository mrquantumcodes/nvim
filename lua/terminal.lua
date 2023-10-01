-- Define a function to open a floating terminal window
function OpenFloatingTerminal()
    local cmd = "terminal"  -- Command to run in the terminal window

    -- Create the terminal buffer
    local terminal_buffer = vim.api.nvim_create_buf(false, true)
    
    -- Create the terminal window
    local terminal_window = vim.api.nvim_open_win(terminal_buffer, true, {
        relative = "editor",
        width = 40,
        height = 10,
        row = 1,
        col = 1,
        style = "minimal",
        border = "single",
    })

    -- Execute the command in the terminal window
    vim.fn.termopen(cmd)

    -- Set key mapping to close the terminal window (F7 in this case)
    vim.api.nvim_buf_set_keymap(terminal_buffer, "t", "<F7>", "<Cmd>q<CR>", { noremap = true, silent = true })

    -- Switch to the terminal buffer
    vim.api.nvim_set_current_buf(terminal_buffer)
end

-- Bind the function to the F7 key
vim.api.nvim_set_keymap('n', '<F7>', '<Cmd>lua OpenFloatingTerminal()<CR>', { noremap = true, silent = true })