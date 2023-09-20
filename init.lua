-- Set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Load plugins from plugins.lua
require("plugins")
require("statusline")

-- Load NvimTree and set it up
require("nvim-tree").setup({
  open_on_tab = true,
  update_cwd = true,
  hijack_cursor = true,
  view = { width = 30 },
  filters = { dotfiles = true },
})

-- Set line numbers to always be on and use relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Map Ctrl+j for previous suggestion in Coc.nvim
vim.api.nvim_set_keymap('i', '<C-j>', 'coc#pum#prev(1)', { noremap = true, expr = true })

-- Map Ctrl+k for next suggestion in Coc.nvim
vim.api.nvim_set_keymap('i', '<C-k>', 'coc#pum#next(1)', { noremap = true, expr = true })

-- Map Ctrl+l for accept suggestion in Coc.nvim
vim.api.nvim_set_keymap('i', '<C-l>', 'coc#_select_confirm()', { noremap = true, expr = true })

-- Function to show or refresh Coc suggestion list
function ShowOrRefreshCocList()
  if vim.fn.pumvisible() == 1 then
      return vim.fn['coc#refresh']()
  else
      return vim.fn['coc#complete']()
  end
end

-- Map Ctrl+Space to show or refresh Coc suggestion list
vim.api.nvim_set_keymap('i', '<C-h>', 'coc#refresh()', { noremap = true, expr = true })





vim.cmd("colorscheme catppuccin")


-- Set tab size to 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Set leader key to spacebar
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "  -- Set leader key to spacebar

-- Toggle NvimTree with <leader>e and switch focus to it if open, or switch back to the previous buffer if closed
vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Focus on NvimTree with leader+ft
vim.api.nvim_set_keymap("n", "<leader>ft", ":NvimTreeFocus<CR>", { noremap = true, silent = true })

-- Focus on current buffer with leader+fb
vim.api.nvim_set_keymap("n", "<leader>fb", "<C-W>w", { noremap = true, silent = true })

-- Open new file in a new buffer
vim.api.nvim_set_keymap("n", "<leader>n", ":enew<CR> :lua statuslinenodelay()<CR> :lua SaveSession()<CR>", { noremap = true, silent = true })

-- Jump to previous buffer with comma
vim.api.nvim_set_keymap("n", ",", ":bprev<CR> :lua statuslinenodelay()<CR> :lua SaveSession()<CR>", { noremap = true, silent = true })

-- Jump to next buffer with period
vim.api.nvim_set_keymap("n", ".", ":bnext<CR> :lua statuslinenodelay()<CR> :lua SaveSession()<CR>", { noremap = true, silent = true })

-- Close current buffer with leader+b+e
vim.api.nvim_set_keymap("n", "<leader>be", ":bd<CR> :lua statuslinenodelay()<CR> :lua SaveSession()<CR>", { noremap = true, silent = true })

-- ... (your existing code)

-- Function to save the current session and buffers
function SaveSessionAndBuffers()
  -- Save the current directory in cwd.txt
  local current_dir = vim.fn.getcwd()
  local cwd_file = io.open("C:/nvim_sessions/cwd.txt", "w")
  cwd_file:write(current_dir)
  cwd_file:close()

  -- Get the list of open buffers using the :ls command
  local buffer_list = vim.fn.execute("ls")
  local buffer_lines = vim.fn.split(buffer_list, "\n")

  -- Open the buffers.txt file for writing
  local buffer_file = io.open("C:/nvim_sessions/buffers.txt", "w")

  -- Loop through buffer_lines and extract buffer paths
  local buffer_paths = {}
  for _, line in ipairs(buffer_lines) do
    -- print(buffer_path)
    -- print(line)
    -- local buffer_path = line:match("\"(.-)\"$")

    buffer_path = string.match(line, '%b""')
    buffer_path = string.gsub(buffer_path, '"', "")

    if buffer_path and not vim.startswith(buffer_path, "NvimTree") then
      -- Expand tilde and remove the cwd from the path
      buffer_path = vim.fn.fnamemodify(buffer_path, ":~:.:p")
      buffer_path = buffer_path:gsub("~", vim.fn.expand("$HOME"))
      buffer_path = vim.fn.fnamemodify(buffer_path, ":~:.:.")
      buffer_paths[#buffer_paths + 1] = buffer_path
    end
  end

  -- Write buffer paths to the file
  for _, buffer_path in ipairs(buffer_paths) do
    buffer_file:write(buffer_path .. "\n")
  end

  buffer_file:close()

  print("Session Saved")
end





local function isempty(s)
  return s == nil or s == ''
end

-- Function to load the session and buffers
function LoadSessionAndBuffers()
  -- Read the saved current directory from cwd.txt
  local cwd_file = io.open("C:/nvim_sessions/cwd.txt", "r")
  local current_dir = cwd_file:read("*line")
  cwd_file:close()

  -- Set the current directory to the saved directory
  vim.fn.chdir(current_dir)

  -- Read the list of buffers from buffers.txt
  local buffer_file = io.open("C:/nvim_sessions/buffers.txt", "r")
  if buffer_file then
    local buffers = {}
    for line in buffer_file:lines() do
      table.insert(buffers, line)
    end
    buffer_file:close()

    -- Close all current buffers
    vim.cmd("silent! %bd")

    -- Open the buffers from buffers.txt
    for _, buffer_path in ipairs(buffers) do
      if not isempty(buffer_path) then
        vim.cmd("edit " .. buffer_path)
      end
    end
  end

  statusline()
end


-- function SaveSession()
--   SaveSessionAndBuffers()
-- end


-- vim.api.nvim_set_keymap("n", "<leader>\\", [[<Cmd>lua SaveSessionAndBuffers()<CR>]], { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader><BS>", [[<Cmd>lua LoadSessionAndBuffers()<CR>]], { noremap = true, silent = true })

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

-- Define the directory where sessions will be stored
session_dir = "C:/nvim_sessions/"

-- Function to save the current session with a name based on the current working directory
function SaveSession()
  vim.cmd("NvimTreeClose")

  -- Create the session directory if it doesn't exist
  createSessionDirectory()

  -- Get the current working directory and replace slashes with double underscores
  local cwd = pathToFilename(vim.fn.getcwd())
  local session_path = session_dir .. cwd .. ".vim"
  vim.cmd("mksession! " .. session_path)

  -- Update the sessions_list.txt file
  local sessions_list_path = session_dir .. "sessions_list.txt"
  updateSessionsList(sessions_list_path, cwd)

  print("Session saved as '" .. session_path .. "'")
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

          print("Session '" .. selected .. "' restored")
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



require('buffman')


-- Set up Telescope
require('telescope').setup({
  defaults = {
    prompt_prefix = '> ',
    selection_caret = '> ',
    layout_strategy = 'horizontal',
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    sorting_strategy = 'ascending',
    file_ignore_patterns = { -- List of folders/files to exclude
      'node_modules',
      'build',
      'to_ignore',
      'images',
      '.jpg',
      '.jpeg',
      '.png',
      '.gif',
      '.avif',
      '.tiff',
      '.webp',
    },
    mappings = {
      i = {
        ["<C-u>"] = false, -- Prevent line clearing in insert mode
        ["<C-d>"] = false, -- Prevent line clearing in insert mode
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- Enable fuzzy finder
      override_generic_sorter = true, -- Use the FZF sorter for all file types
      override_file_sorter = true, -- Use the FZF sorter for file types
    },
  },
})

-- Keybindings for Telescope and ripgrep
vim.api.nvim_set_keymap("n", "<leader>ff", [[<Cmd>Telescope find_files<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fg", [[<Cmd>Telescope live_grep<CR>]], { noremap = true, silent = true })


-- Set F7 key to toggle the terminal
vim.api.nvim_set_keymap("n", "<F7>", ":ToggleTermOpenAll<CR>", { noremap = true, silent = true })


-- Set Prettier configuration
-- vim.g["prettier#autoformat"] = true
-- vim.g["prettier#autoformat_require_pragma"] = false

-- -- Set autoindent to always true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- -- ... (other settings and keybindings)

-- -- Automatically format code using Prettier on save
-- vim.cmd("autocmd BufWritePre * Prettier")

-- local cmp = require("cmp")

-- require("luasnip.loaders.from_vscode").lazy_load()

-- cmp.setup({
--   mapping = cmp.mapping.preset.insert({
--       ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--       ['<C-f>'] = cmp.mapping.scroll_docs(4),
--       ['<C-o>'] = cmp.mapping.complete(),
--       ['<C-e>'] = cmp.mapping.abort(),
--       ['<CR>'] = cmp.mapping.confirm({ select = true }),
--     }),
--   snippet = {
--     expand = function(args)
--       require('luasnip').lsp_expand(args.body)
--     end,
--   },
--   sources = cmp.config.sources({
--     { name = 'nvim_lsp' },
--     { name = 'luasnip' },
--   }, {
--     { name = 'buffer' },
--   }),
-- })


-- require('nvim-autopairs').setup{} -- Add this line


function FormatCode()
  vim.cmd("normal gg=G``")
end

-- vim.api.nvim_set_keymap("n", "<leader>fp", ":lua FormatCode()<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>fp', ':CocCommand prettier.formatFile<CR>', { noremap = true, silent = true })

-- remap leader+w to save file
vim.api.nvim_set_keymap('n', '<Leader>w', ':w<CR>', { noremap = true, silent = true })
