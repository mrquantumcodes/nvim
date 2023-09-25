-- Function to list files and directories recursively
local function list_files(path)
    local files = {}
    for entry in vim.fn.readdir(path, "n") do
        local full_path = path .. "/" .. entry
        if vim.fn.isdirectory(full_path) == 1 then
            table.insert(files, { name = entry, is_directory = true, path = full_path })
            local sub_files = list_files(full_path)
            for _, sub_entry in ipairs(sub_files) do
                table.insert(files, sub_entry)
            end
        else
            table.insert(files, { name = entry, is_directory = false, path = full_path })
        end
    end
    return files
end

-- Function to create and show the popup file tree
function show_file_tree()
	print("hi")
    local cwd = vim.fn.getcwd()
    local files = list_files(cwd)

    local items = {}
    for _, file in ipairs(files) do
        local prefix = file.is_directory and "+" or " "
        local item_text = prefix .. " " .. file.name
        table.insert(items, item_text)
    end

    local popup_opts = {
        style = "minimal",
        border = "single",
        relative = "cursor",
        row = 1,
        col = 0,
        width = 30,
        height = #items + 2,  -- Add 2 for borders
        zindex = 50,
    }

    local popup_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(popup_buf, 0, -1, false, items)
    vim.api.nvim_buf_set_option(popup_buf, "modifiable", false)
    local popup_win = vim.api.nvim_open_win(popup_buf, true, popup_opts)

    -- Map Enter key to open or close directories
    vim.api.nvim_buf_set_keymap(popup_buf, "n", "<CR>", ":lua toggle_directory()<CR>", {})

    -- Function to toggle directory expansion
    local expanded_dirs = {}
    function toggle_directory()
        local line = vim.fn.line(".")
        local file = files[line]
        if file and file.is_directory then
            if expanded_dirs[line] then
                expanded_dirs[line] = nil
                vim.api.nvim_buf_set_lines(popup_buf, line, line + #file.items, false, {})
            else
                expanded_dirs[line] = true
                local sub_items = {}
                for _, sub_file in ipairs(file.items) do
                    local sub_prefix = sub_file.is_directory and "+" or " "
                    local sub_item_text = sub_prefix .. " " .. sub_file.name
                    table.insert(sub_items, sub_item_text)
                end
                vim.api.nvim_buf_set_lines(popup_buf, line, line, false, sub_items)
            end
        end
    end
end

-- Map a key to show the file tree popup
