vim.loader.enable()

require("plugins_lazy")
vim.cmd("colorscheme sorbet")


-- Set termguicolors to enable highlight groups
vim.opt.termguicolors    = true

-- Set leader key to spacebar
vim.g.mapleader          = " " -- sets leader key

vim.g.netrw_dirhistmax   = 10
vim.g.netrw_dirhist_cnt  = 6
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

-- Load plugins from plugins.lua
require("treesitter")
require("wordplay")



vim.cmd("set invhlsearch")
vim.cmd("set cursorline")
-- vim.cmd("colorscheme torte")

require("statusline")
require("lspzero")

require("persistent_undo")

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

-- Set tab size to 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.cmd('set guicursor=n-v-c-i:block')

require('keymaps')
require('indentline')
require('autorename_tag')
-- require('filetree')

-- -- Set autoindent to always true
vim.opt.smartindent = true
vim.opt.autoindent = true