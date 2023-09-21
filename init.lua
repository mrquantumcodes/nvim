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

-- -- Jump to previous buffer with comma
-- vim.api.nvim_set_keymap("n", ",", ":bprev<CR> :lua statuslinenodelay()<CR> :lua SaveSession()<CR>", { noremap = true, silent = true })

-- -- Jump to next buffer with period
-- vim.api.nvim_set_keymap("n", ".", ":bnext<CR> :lua statuslinenodelay()<CR> :lua SaveSession()<CR>", { noremap = true, silent = true })

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- Close current buffer with leader+b+e
vim.api.nvim_set_keymap("n", "<leader>be", ":bd<CR> :lua statuslinenodelay()<CR> :lua SaveSession()<CR>", { noremap = true, silent = true })


session_dir = "C:/nvim_sessions/"


require('findex')

require('susman')

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
-- vim.api.nvim_set_keymap("n", "<leader>ff", [[<Cmd>Telescope find_files<CR>]], { noremap = true, silent = true })
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

-- Map Caps Lock to Escape in Neovim
vim.api.nvim_set_keymap('n', '<CapsLock>', '<Esc>', { noremap = true, silent = true })
