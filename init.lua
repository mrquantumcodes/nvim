vim.loader.enable();


require("plugins");
require("mrquantum.keymaps");

vim.opt.clipboard     = "unnamedplus"

require("mrquantum.statusline");
require("mrquantum.indentline");

require("mrquantum.autorename_tag");
require("mrquantum.wordplay");


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
vim.opt.expandtab = true

vim.cmd('set guicursor=n-v-c-i:block')
