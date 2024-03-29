vim.loader.enable()

require("plugins_lazy")
-- vim.cmd("colorscheme tokyonight-night")


-- Set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Set leader key to spacebar
vim.g.mapleader       = " " -- sets leader key

vim.g.netrw_banner    = 0   -- gets rid of the annoying banner for netrw
-- vim.g.netrw_browse_split = 4   -- open in prior window
vim.g.netrw_altv      = 1   -- change from left splitting to right splitting
vim.cmd('set path+=**')     -- search current directory recursively
vim.opt.hlsearch      = false

-- vim.g.netrw_dirhistmax   = 10
-- vim.g.netrw_dirhist_cnt  = 6
--vim.cmd("let g:netrw_list_hide=netrw_gitignore#Hide()")
vim.opt.title         = true -- show title
vim.opt.syntax        = "ON"
vim.opt.showtabline   = 2    -- always show the tab line
vim.opt.scrolloff     = 8    -- scroll page when cursor is 8 lines from top/bottom
vim.opt.sidescrolloff = 8    -- scroll page when cursor is 8 spaces from left/right
vim.opt.laststatus    = 2    -- always show statusline
vim.opt.signcolumn    = "auto"
vim.opt.expandtab     = false
vim.opt.clipboard     = "unnamedplus"
vim.cmd('filetype plugin on') -- set filetype
vim.cmd('set wildmenu')       -- enable wildmenu

-- Load plugins from plugins.lua
-- require("treesitter")
require("wordplay")



-- vim.cmd("set invhlsearch")
vim.cmd("set cursorline")
-- vim.cmd("colorscheme torte")

require("statusline")
-- require("lspzero")

require("persistent_undo")

-- Set line numbers to always be on and use relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
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

-- require('commentary')

-- -- Set autoindent to always true
vim.opt.smartindent = true
vim.opt.autoindent = true


vim.cmd("set guicursor=a:blinkon100")

vim.cmd("hi NormalFloat guibg=none")
vim.cmd("hi FloatBorder guibg=#ccc")

-- local root_files = {'composer.json'}
-- local paths = vim.fs.find(root_files, {stop = vim.env.HOME})

-- vim.lsp.start({
--   cmd = {'C:/Users/Admin/AppData/Local/nvim-data/mason/bin/intelephense.cmd', '--stdio'},
--   filetypes = { 'php' },
--   root_dir = vim.fs.dirname(paths[1]),
--   settings = {
--     intelephense = {
--       files = {
--         maxSize = 1000000,
--       },
--     }
--   }
-- })



vim.keymap.set("i", "<Tab>", "coc#pum#visible() ? '<Tab>' : '<Tab>'", { expr = true })
