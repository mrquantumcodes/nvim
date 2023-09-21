-- Define a custom :Findex command
vim.cmd("command! -nargs=0 Findex :lua FindexFunction()")

-- session_dir defined in init.lua

-- Define the indexing function
function FindexFunction()
    local session_name = vim.fn.eval('v:this_session')
    -- print(session_dir, session_name)
    local index_exceptions = { ".git/", "images/", ".jpg", ".png", ".gif", ".pdf", ".avif", ".tiff", ".webp" }

    local indexed_files = {}  -- Table to store indexed file paths

    -- Function to recursively scan files
    local function scan_directory(directory)
        local entries = vim.fn.readdir(directory)
        if not entries then
            return
        end

        for _, entry in ipairs(entries) do
            local path = directory .. entry
            path = path:gsub("\\", "/")  -- Convert backslashes to forward slashes

            if vim.fn.isdirectory(path) == 1 then
                -- It's a directory; recursively scan it unless it's in exceptions
                for k, v in ipairs(index_exceptions) do
                    if not vim.tbl_contains(index_exceptions, entry) then
                        scan_directory(path .. "/")
                    end
                end
            elseif vim.fn.isdirectory(path) == 0 then
                -- It's a file; add it to the indexed_files table unless it's in exceptions
                if not string.find(path, ".git") then
                    local extension = path:match("%.([^%.]+)$")
                    -- print(extension)
                    if extension ~= nil then
                        if not vim.tbl_contains(index_exceptions, "." .. extension) then
                            table.insert(indexed_files, path)
                        end
                    end
                end
            end
        end
    end

    -- Start scanning from the current working directory with a trailing slash
    local cwd = vim.fn.getcwd()
    if not cwd:match("/$") then
        cwd = cwd .. "/"
    end

    scan_directory(cwd)

    -- Save the list of indexed files to a file in the session directory
	-- print(session_name:gsub("%.vim", "") .. ".txt")
    local index_file = io.open(session_name:gsub("%.vim", "") .. ".txt", "w")
    if index_file then
        for _, file in ipairs(indexed_files) do
            index_file:write(file .. "\n")
        end
        index_file:close()
        print("Indexing complete. Results saved in '" .. session_name:gsub("%.vim", "") .. ".txt")
    else
        print("Error: Could not open the index file for writing.")
    end
end


-- Define a custom :Fselect command
vim.cmd("command! -nargs=0 Fselect :lua FselectFunction()")

-- Define the function to display and select indexed items
function FselectFunction()
    local session_name = vim.fn.eval('v:this_session')
    local index_file_path = session_name:gsub("%.vim", "") .. ".txt"
    
    -- Read the indexed items from the file
    local indexed_items = {}
    local index_file = io.open(index_file_path, "r")
    if index_file then
        for line in index_file:lines() do
            table.insert(indexed_items, line)
        end
        index_file:close()
    else
        print("Error: Could not open the index file for reading.")
        return
    end

    -- Display the list of indexed items using vim.ui.select
    vim.ui.select(indexed_items, {
        prompt = "Select an item to open",
    }, function(selected)
        if selected ~= "" and selected ~= nil then
            -- Open the selected item in Neovim
            vim.cmd("edit " .. selected)
        end
    end)
end


vim.api.nvim_set_keymap("n", "<leader>ff", [[<Cmd>Fselect<CR>]], { noremap = true, silent = true })