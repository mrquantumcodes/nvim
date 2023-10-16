-- -- Function to draw the buffer tabline
-- function drawBufferTabline()
--     local tabline = "%#TabLine#"
--     local current_bufnr = vim.fn.bufnr('%')
    
--     for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
--         local bufname = vim.fn.bufname(bufnr)
--         local modified = vim.fn.getbufvar(bufnr, '&modified')
        
--         -- Define the tab's appearance based on current buffer and modification status
--         local tab = ("%s%s %s %s"):format(
--             bufnr == current_bufnr and "%#TabLineSel#" or "%#TabLine#",
--             modified == 1 and "✳" or " ",
--             bufnr == current_bufnr and "▶" or " ",
--             bufname
--         )
        
--         tabline = tabline .. tab
--     end
    
--     -- Set the tabline in the statusline
--     vim.fn.settabline('', tabline)
-- end

-- -- Set up autocmd to update the buffer tabline on BufEnter and BufDelete
-- vim.api.nvim_command('autocmd BufEnter, BufDelete * lua drawBufferTabline()')

-- -- Initial draw of the buffer tabline
-- drawBufferTabline()





