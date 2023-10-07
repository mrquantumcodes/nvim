-- Set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Set leader key to spacebar
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " " -- Set leader key to spacebar

-- Load plugins from plugins.lua
require("plugins")
-- require("treesitter")
vim.cmd("colorscheme tokyonight-night")
vim.cmd("set invhlsearch")
-- vim.cmd("colorscheme torte")

require("statusline")

require("persistent_undo")


require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = {  },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "json" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    -- disable = function(lang, buf)
    --     local max_filesize = 100 * 1024 -- 100 KB
    --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --     if ok and stats and stats.size > max_filesize then
    --         return true
    --     end
    -- end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}


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

-- Map Ctrl+j for previous suggestion in Coc.nvim
-- vim.api.nvim_set_keymap('i', '<C-j>', 'coc#pum#prev(1)', { noremap = true, expr = true })

-- -- Map Ctrl+k for next suggestion in Coc.nvim
-- vim.api.nvim_set_keymap('i', '<C-k>', 'coc#pum#next(1)', { noremap = true, expr = true })

-- Map Ctrl+l for accept suggestion in Coc.nvim
vim.api.nvim_set_keymap('i', '<C-o>', 'coc#_select_confirm()', { noremap = true, expr = true })

-- Function to show or refresh Coc suggestion list
function ShowOrRefreshCocList()
  if vim.fn.pumvisible() == 1 then
    return vim.fn['coc#refresh']()
  else
    return vim.fn['coc#complete']()
  end
end

-- Map Ctrl+Space to show or refresh Coc suggestion list
vim.api.nvim_set_keymap('i', '<C-e>', 'coc#refresh()', { noremap = true, expr = true })


require("bufferchad").setup({
  mapping = "<leader>bb",
  mark_mapping = "<leader>bm",
  order = "LAST_USED_UP",
  style='default'
})

-- Set tab size to 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Toggle NvimTree with <leader>e and switch focus to it if open, or switch back to the previous buffer if closed
vim.api.nvim_set_keymap("n", "<leader>ee", ":NERDTreeToggle<CR>", { noremap = true, silent = true })

-- Toggle NvimTree with <leader>e and switch focus to it if open, or switch back to the previous buffer if closed
vim.api.nvim_set_keymap("n", "<leader>ec", ":NERDTreeClose<CR>", { noremap = true, silent = true })

-- Focus on NvimTree with leader+ft
vim.api.nvim_set_keymap("n", "<leader>ft", ":NERDTreeFocus<CR>", { noremap = true, silent = true })

-- Nerd Tree Search with leader+fb
vim.api.nvim_set_keymap("n", "<leader>fb", "NERDTreeFind<CR>", { noremap = true, silent = true })


-- Open new file in a new buffer
vim.api.nvim_set_keymap("n", "<leader>n", ":enew<CR> :lua SaveSession()<CR>", { noremap = true, silent = true })


vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- Close current buffer with leader+b+e
vim.api.nvim_set_keymap("n", "<leader>be", ":bd<CR> :lua SaveSession()<CR>", { noremap = true, silent = true })


-- session_dir = vim.fn.stdpath('data') .. "\\nvim_sessions\\"


-- require('findex')

require('lua.retrospect.lua.retrospect').setup({})

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
vim.api.nvim_set_keymap('n', '<Leader>w', ':lua SaveSession()<CR>:w<CR>', { noremap = true, silent = true })

-- Map Caps Lock to Escape in Neovim
vim.api.nvim_set_keymap('n', '<CapsLock>', '<Esc>', { noremap = true, silent = true })


require('teltest')