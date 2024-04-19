vim.loader.enable();


require("plugins");

require("mrquantum.wordplay");
require("mrquantum.keymaps");

-- require("configpulse");

vim.opt.clipboard     = "unnamedplus"

-- Set termguicolors to enable highlight groups
vim.opt.termguicolors = true

vim.cmd('set path+=**') -- search current directory recursively


-- vim.opt.title         = true -- show title
vim.opt.syntax        = "ON"
-- vim.opt.showtabline   = 2    -- always show the tab line
vim.opt.scrolloff     = 8    -- scroll page when cursor is 8 lines from top/bottom
vim.opt.sidescrolloff = 8    -- scroll page when cursor is 8 spaces from left/right
vim.opt.laststatus    = 2    -- always show statusline
vim.opt.signcolumn    = "auto"
vim.opt.expandtab     = false
vim.opt.clipboard     = "unnamedplus"
vim.cmd('filetype plugin on') -- set filetype
vim.cmd('set wildmenu')       -- enable wildmenu

require("mrquantum.statusline");
require("mrquantum.indentline");

require("mrquantum.autorename_tag");


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


vim.cmd.set("invhlsearch")
vim.cmd.set("cursorline")


-- Set line numbers to always be on and use relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.foldmethod = "manual"


-- Set tab size to 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.showtabline = 1

vim.cmd('set guicursor=n-v-c-i:block')

-- -- Set autoindent to always true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- set autocmd to set vim.o.timeoutlen = 120 in insert mode then set it back to 1000 in normal mode
vim.cmd([[
  autocmd InsertEnter * set timeoutlen=120
  autocmd InsertLeave * set timeoutlen=1000
]])
