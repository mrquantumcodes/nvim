-- init.lua (or init.vim if you prefer Vimscript)

-- Function to toggle the terminal
function ToggleTerminal()
    local bufnr = vim.fn.bufnr('^term://')
    if bufnr > 0 then
        -- Close the terminal window
        vim.api.nvim_win_close(0, true)
    else
        -- Open a new floating terminal window
        local term_buf = vim.fn.termopen('nu', {
            on_exit = function(_, code)
                if code == 0 then
                    -- Terminal exited normally, close the window
                    vim.api.nvim_win_close(0, true)
                end
            end,
        })
        vim.api.nvim_open_win(term_buf, true, {
            relative = 'editor',
            width = vim.o.columns * 0.5,  -- Half the width of Neovim window
            height = vim.o.lines * 0.5,   -- Half the height of Neovim window
            row = 1,
            col = 1,
            style = 'minimal',
            border = 'single',
            focusable = true,
            bufpos = { 0, 1 },
            zindex = 50,
        })
    end
end

-- Map <F5> to toggle the terminal
vim.api.nvim_set_keymap('n', '<F5>', ':lua ToggleTerminal()<CR>', { noremap = true, silent = true })
