require("plugins_lazy")
vim.cmd("colorscheme tokyonight-night")

-- Set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Set leader key to spacebar
-- vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })

vim.g.mapleader = " "        -- sets leader key
vim.g.netrw_banner = 0       -- gets rid of the annoying banner for netrw
vim.g.netrw_browse_split = 4 -- open in prior window
vim.g.netrw_altv = 1         -- change from left splitting to right splitting
vim.g.netrw_liststyle = 3    -- tree style view in netrw
--vim.cmd("let g:netrw_list_hide=netrw_gitignore#Hide()")
vim.opt.title = true         -- show title
vim.cmd('set path+=**')      -- search current directory recursively
vim.opt.syntax = "ON"
vim.opt.showtabline = 2      -- always show the tab line
vim.opt.scrolloff = 8        -- scroll page when cursor is 8 lines from top/bottom
vim.opt.sidescrolloff = 8    -- scroll page when cursor is 8 spaces from left/right
vim.opt.laststatus = 2       -- always show statusline
vim.opt.signcolumn = "auto"
vim.opt.expandtab = false
vim.opt.clipboard = "unnamedplus"
vim.cmd('filetype plugin on') -- set filetype
vim.cmd('set wildmenu')       -- enable wildmenu
-- vim.cmd('hi TabLine      guifg=#333 guibg=#222 gui=none ctermfg=254 ctermbg=238 cterm=none')
-- vim.cmd('hi TabLineSel   guifg=#ababab guibg=#343445 gui=bold ctermfg=231 ctermbg=235 cterm=bold')
-- vim.cmd('hi TabLineFill  guifg=#ababab guibg=transparent gui=bold ctermfg=254 ctermbg=238 cterm=bold')

-- vim.g.mapleader = " " -- Set leader key to spacebar

-- Load plugins from plugins.lua
require("treesitter")



vim.cmd("set invhlsearch")
vim.cmd("set cursorline")
-- vim.cmd("colorscheme torte")

require("statusline")
require("lspzero")

require("persistent_undo")

-- vim.cmd("hi Normal guibg=black ctermbg=black")




-- Set line numbers to always be on and use relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.foldmethod = "manual"

vim.cmd([[
  augroup JSONConceal
    autocmd!
    autocmd FileType json let g:vim_json_conceal=0
  augroup END
]])

-- Remap Alt+Shift+F to format using Coc
-- vim.api.nvim_set_keymap('n', '<A-S-F>', [[:call CocActionAsync('format')<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-S-F>', [[:LspZeroFormat<CR>]], { noremap = true, silent = true })


-- Map Ctrl+j for previous suggestion in Coc.nvim
-- vim.api.nvim_set_keymap('i', '<C-j>', 'coc#pum#prev(1)', { noremap = true, expr = true })

-- -- Map Ctrl+k for next suggestion in Coc.nvim
-- vim.api.nvim_set_keymap('i', '<C-k>', 'coc#pum#next(1)', { noremap = true, expr = true })

-- Map Ctrl+l for accept suggestion in Coc.nvim
-- vim.api.nvim_set_keymap('i', '<C-o>', 'coc#_select_confirm()', { noremap = true, expr = true })

-- Function to show or refresh Coc suggestion list
-- function ShowOrRefreshCocList()
--   if vim.fn.pumvisible() == 1 then
--     return vim.fn['coc#refresh']()
--   else
--     return vim.fn['coc#complete']()
--   end
-- end

-- -- Map Ctrl+Space to show or refresh Coc suggestion list
-- vim.api.nvim_set_keymap('i', '<C-e>', 'coc#refresh()', { noremap = true, expr = true })


require("bufferchad").setup({
  mapping = "<leader>bb",
  mark_mapping = "<leader>bm",
  order = "LAST_USED_UP",
  style = 'default'
})

-- Set tab size to 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Toggle NvimTree with <leader>e and switch focus to it if open, or switch back to the previous buffer if closed
-- See plugins_lazy
vim.api.nvim_set_keymap("n", "<leader>ee", ":25Lex<CR>", { noremap = true, silent = true })

-- Toggle NvimTree with <leader>e and switch focus to it if open, or switch back to the previous buffer if closed
vim.api.nvim_set_keymap("n", "<leader>ec", ":lua CloseNetrw()<CR>", { noremap = true, silent = true })

-- Focus on NvimTree with leader+ft
-- vim.api.nvim_set_keymap("n", "<leader>ft", ":Neotree focus<CR>", { noremap = true, silent = true })

-- Nerd Tree Search with leader+fb
-- vim.api.nvim_set_keymap("n", "<leader>fb", "NERDTreeFind<CR>", { noremap = true, silent = true })



vim.api.nvim_set_keymap('i', '<C-s>',
  '<Esc> :lua CloseNetrw()<CR> :UndotreeHide<CR> :w<CR>:lua retrospect.  SaveSession()<CR>',
  { noremap = true, silent = true })


-- Open new file in a new buffer
vim.api.nvim_set_keymap("n", "<leader>n",
  ":enew<CR> :lua CloseNetrw()<CR> :UndotreeHide<CR> :lua retrospect.SaveSession()<CR>",
  { noremap = true, silent = true })


vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- Close current buffer with leader+b+e
vim.api.nvim_set_keymap("n", "<leader>be",
  ":bd<CR> :lua CloseNetrw()<CR> :UndotreeHide<CR> :lua retrospect.SaveSession()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>d",
  ":bd<CR> :lua CloseNetrw()<CR> :UndotreeHide<CR> :lua retrospect.SaveSession()<CR>", { noremap = true, silent = true })


function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- map('i', 'jk', '<Esc>')
-- map('i', 'kj', '<Esc>')
map('i', '<C-h>', '<Esc>')

-- Visual Maps
map("v", "<leader>r", "\"hy:%s/<C-r>h//g<left><left>")			    -- Replace all instances of highlighted words 
map("v", "<C-s>", ":sort<CR>")									-- Sort highlighted text in visual mode with Control+S
map("v", "J", ":m '>+1<CR>gv=gv")								-- Move current line down
map("v", "K", ":m '>-2<CR>gv=gv")								-- Move current line up 


-- Move selected lines down in visual mode and visual block mode
map("x", "J", ":move '>+1<CR>gv=gv")

-- Move selected lines up in visual mode and visual block mode
map("x", "K", ":move '<-2<CR>gv=gv")



-- session_dir = vim.fn.stdpath('data') .. "\\nvim_sessions\\"


-- require('findex')

retrospect = require('retrospect')
retrospect.setup({
  style = "default"
})

-- require('buffman')


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
      '**/node_modules/**',
      '**build/**',
      '**to_ignore/**',
      '**images/**',
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
      fuzzy = true,                   -- Enable fuzzy finder
      override_generic_sorter = true, -- Use the FZF sorter for all file types
      override_file_sorter = true,    -- Use the FZF sorter for file types
    },
  },
})

-- Keybindings for Telescope and ripgrep
vim.api.nvim_set_keymap("n", "<leader>ff", [[<Cmd>Telescope find_files<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fg", [[<Cmd>Telescope live_grep<CR>]], { noremap = true, silent = true })


-- Set F7 key to toggle the terminal
-- vim.api.nvim_set_keymap("n", "<F7>", ":ToggleTermOpenAll<CR>", { noremap = true, silent = true })

require('terminal')


-- Set Prettier configuration
-- vim.g["prettier#autoformat"] = true
-- vim.g["prettier#autoformat_require_pragma"] = false

-- -- Set autoindent to always true
vim.opt.autoindent = true
vim.opt.smartindent = true


-- remap leader+w to save file
vim.api.nvim_set_keymap('n', '<Leader>w',
  ':lua CloseNetrw()<CR> :UndotreeHide<CR> :lua retrospect.SaveSession()<CR>:w<CR>',
  { noremap = true, silent = true })

-- Map Caps Lock to Escape in Neovim
-- vim.api.nvim_set_keymap('n', '<CapsLock>', '<Esc>', { noremap = true, silent = true })


require('teltest')
require('buffline')

-- tabline
-- vim.cmd("source " .. vim.fn.stdpath('config') .. "/lua/buftabline.vim")
