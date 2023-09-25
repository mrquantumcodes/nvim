-- Function to encode a path to a reversible string
function pathToFilename(path)
  local encoded = ""
  for i = 1, #path do
      encoded = encoded .. string.byte(path, i) .. "_"
  end
  return encoded
end

-- Function to decode a reversible string back to a path
function filenameToPath(filename)
  local decoded = ""
  local parts = {}
  for part in filename:gmatch("[^_]+") do
      table.insert(parts, tonumber(part))
  end
  for _, value in ipairs(parts) do
      decoded = decoded .. string.char(value)
  end
  return decoded
end


vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>:lua SaveSession()<CR>', { noremap = true, silent = true })

-- Function to save the current session with a name based on the current working directory
function SaveSession()
  vim.cmd("NERDTreeClose")
  vim.cmd("UndotreeHide")


  if vim.fn.getcwd():gsub("\\", "/"):gsub("~", vim.fn.expand("$HOME")) == vim.fn['stdpath']('config'):gsub("\\", "/"):gsub("~", vim.fn.expand("$HOME")) then
    print("Cannot create a session for the Neovim config folder")
    return
  end

  -- Create the session directory if it doesn't exist
  createSessionDirectory()

  -- Get the current working directory and replace slashes with double underscores
  local cwd = pathToFilename(vim.fn.getcwd())
  local session_path = session_dir .. cwd .. ".vim"
  vim.cmd("mksession! " .. session_path)

  -- Update the sessions_list.txt file
  local sessions_list_path = session_dir .. "sessions_list.txt"
  updateSessionsList(sessions_list_path, cwd)

  print("Session saved")
end

-- Function to create the session directory if it doesn't exist
function createSessionDirectory()
  local session_dir_exists = vim.fn.isdirectory(session_dir)
  if session_dir_exists == 0 then
      vim.fn.mkdir(session_dir, "p")
  end
end

-- Function to update sessions_list.txt
function updateSessionsList(file_path, current_session_name)
  local sessions = {}  -- Table to store session names

  -- Set the first item to the current session name by default
  table.insert(sessions, current_session_name .. ".vim")

  -- Get a list of .vim files in the session directory
  local vim_files = vim.fn.glob(session_dir .. "*.vim", true, true)

  -- Extract and add session names from file paths
  for _, file in ipairs(vim_files) do
      local session_name = vim.fn.fnamemodify(file, ":t")
      if session_name and session_name ~= current_session_name .. ".vim" then
          table.insert(sessions, session_name)
      end
  end

  -- Write the updated session list to sessions_list.txt
  local file = io.open(file_path, "w")
  if file then
      for _, session in ipairs(sessions) do
          file:write(session .. "\n")
      end
      file:close()
  else
      print("Error: Could not open " .. file_path .. " for writing.")
  end
end


-- Function to restore a session from the selected session file
function RestoreSession()
  if vim.fn.isdirectory(session_dir) == 0 or vim.fn['filereadable'](session_dir .. "sessions_list.txt") == 0 then
    print("No session has been created yet")
    return
  end


  local sessions_list_path = session_dir .. "sessions_list.txt"
  local sessions_list = vim.fn.readfile(sessions_list_path)
  
  if #sessions_list == 0 then
      print("No session files found in " .. session_dir)
      return
  end

  local slist = {};

  for k, v in pairs(sessions_list) do
    table.insert(slist, filenameToPath(v))
  end

  vim.ui.select(slist, {
      prompt = "Select a session to restore",
  }, function(selected)
      if selected ~= "" and selected ~= nil then
          local session_path = session_dir .. pathToFilename(selected:gsub(".vim", "")) .. ".vim"
          vim.cmd("source " .. session_path)

          local sessions_list_path = session_dir .. "sessions_list.txt"
          updateSessionsList(sessions_list_path, pathToFilename(selected:gsub(".vim", "")))

          print("Session restored")

          statusline()

      end
  end)
end

function DeleteSession()
  local sname = vim.fn.eval('v:this_session'):gsub(session_dir, "")

  if sname == "" or sname == nil then
    print("You must open a session to delete it")
  else
    local Input = require("nui.input")
    local event = require("nui.utils.autocmd").event

    local input = Input({
      position = "50%",
      size = {
        width = 34,
      },
      border = {
        style = "single",
        text = {
          top = "[Type yes to confirm]",
          top_align = "center",
        },
      },
      win_options = {
        winhighlight = "Normal:Normal,FloatBorder:Normal",
      },
    }, {
      prompt = "> ",
      default_value = "",
      on_close = function()
        print("Session deletion cancelled")
      end,
      on_submit = function(value)
        if value == "yes" then
        
          local sessions = {}  -- Table to store session names

          vim.fn.delete(session_dir .. sname)
          
          -- Get a list of .vim files in the session directory
          local vim_files = vim.fn.glob(session_dir .. "*.vim", true, true)

          -- Extract and add session names from file paths
          for _, file in ipairs(vim_files) do
              local session_name = vim.fn.fnamemodify(file, ":t")
              table.insert(sessions, session_name)
          end

          -- Write the updated session list to sessions_list.txt
          local file = io.open(session_dir .. "sessions_list.txt", "w")
          if file then
              for _, session in ipairs(sessions) do
                  file:write(session .. "\n")
              end
              file:close()
          else
              print("Error: Could not open " .. session_dir .. "sessions_list.txt" .. " for writing.")
          end
        else
          print("Session deletion cancelled")
        end
      end,
    })

    -- mount/open the component
    input:mount()

    -- unmount component when cursor leaves buffer
    input:on(event.BufLeave, function()
      input:unmount()
    end)
  end
end

vim.cmd([[command! DelSession lua DeleteSession() ]])


function GotoSettings()
  local conf = vim.fn['stdpath']('config')
  vim.cmd("cd " .. conf)
end

vim.cmd([[command! Nset lua GotoSettings() ]])


-- Map Leader+\ to save the current session with a name based on the cwd
vim.api.nvim_set_keymap('n', '<Leader>\\', ':lua SaveSession()<CR>', { noremap = true, silent = true })

-- Map Leader+Backspace to restore a session from a list of available sessions
vim.api.nvim_set_keymap('n', '<Leader><BS>', ':lua RestoreSession()<CR>', { noremap = true, silent = true })


