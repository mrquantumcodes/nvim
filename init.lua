require("plugins_lazy")
vim.cmd("colorscheme tokyonight-night")
-- vim.cmd("colorscheme rose-pine")
-- vim.cmd("colorscheme kanagawa")

-- Set termguicolors to enable highlight groups
vim.opt.termguicolors    = true

-- Set leader key to spacebar
vim.g.mapleader          = " " -- sets leader key
vim.g.netrw_banner       = 0   -- gets rid of the annoying banner for netrw
vim.g.netrw_browse_split = 4   -- open in prior window
vim.g.netrw_altv         = 1   -- change from left splitting to right splitting
vim.g.netrw_liststyle    = 3   -- tree style view in netrw
vim.g.netrw_dirhistmax   = 10
vim.g.netrw_dirhist_cnt  = 6
-- vim.g.netrw_
--vim.cmd("let g:netrw_list_hide=netrw_gitignore#Hide()")
vim.opt.title            = true -- show title
vim.cmd('set path+=**')         -- search current directory recursively
vim.opt.syntax = "ON"
vim.opt.showtabline = 2         -- always show the tab line
vim.opt.scrolloff = 8           -- scroll page when cursor is 8 lines from top/bottom
vim.opt.sidescrolloff = 8       -- scroll page when cursor is 8 spaces from left/right
vim.opt.laststatus = 2          -- always show statusline
vim.opt.signcolumn = "auto"
vim.opt.expandtab = false
vim.opt.clipboard = "unnamedplus"
vim.cmd('filetype plugin on') -- set filetype
vim.cmd('set wildmenu')       -- enable wildmenu
-- vim.cmd('hi TabLine      guifg=#333 guibg=#222 gui=none ctermfg=254 ctermbg=238 cterm=none')
-- vim.cmd('hi TabLineSel   guifg=#ababab guibg=#343445 gui=bold ctermfg=231 ctermbg=235 cterm=bold')
-- vim.cmd('hi TabLineFill  guifg=#ababab guibg=transparent gui=bold ctermfg=254 ctermbg=238 cterm=bold')

-- Load plugins from plugins.lua
require("treesitter")
require("wordplay")



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

vim.cmd([[
  augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=124.35 }
  augroup END
]])

-- Remap Alt+Shift+F to format using Coc
vim.api.nvim_set_keymap('n', '<A-S-F>', [[:call CocActionAsync('format')<CR>]], { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<A-S-F>', [[:LspZeroFormat<CR>]], { noremap = true, silent = true })


-- Set up Telescope
require('telescope').setup({
  defaults = {
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
        -- ["<C-u>"] = false, -- Prevent line clearing in insert mode
        -- ["<C-d>"] = false, -- Prevent line clearing in insert mode
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



require("bufferchad/lua/bufferchad").setup({
  -- mapping = "<leader>bb",
  -- mark_mapping = "<leader>bm",
  -- order = "LAST_USED_UP",
  style = "telescope",
})

-- print("HI")
-- print(pcall(require, 'telescope'))
-- print("HI")


-- Set tab size to 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- session_dir = vim.fn.stdpath('data') .. "\\nvim_sessions\\"


-- require('findex')

retrospect = require('retrospect')
retrospect.setup({
  style = "modern"
})

-- require('buffman')

vim.cmd('set guicursor=n-v-c-i:block')

require('terminal')


-- Set Prettier configuration
-- vim.g["prettier#autoformat"] = true
-- vim.g["prettier#autoformat_require_pragma"] = false

-- Map Caps Lock to Escape in Neovim
-- vim.api.nvim_set_keymap('n', '<CapsLock>', '<Esc>', { noremap = true, silent = true })

require('keymaps')
require('indentline')

-- init.vim or init.lua


-- tabline
-- vim.cmd("source " .. vim.fn.stdpath('config') .. "/lua/buftabline.vim")

-- require("copilot_old")


-- not required right now, see wordplay.lua
-- map("v", "J", ":m '>+1<CR>gv=gv")                      -- Move current line down
-- map("v", "K", ":m '>-2<CR>gv=gv")                      -- Move current line up


-- -- Set autoindent to always true
vim.opt.smartindent = true
vim.opt.autoindent = true
-- print(vim.opt.autoindent:get())
