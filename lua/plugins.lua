-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use { "catppuccin/nvim", as = "catppuccin" }

  -- Simple plugins can be specified as strings
  use 'rstacruz/vim-closer'

  -- Lazy loading:
  -- Load on specific commands
  use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

  -- Load on an autocommand event
  use {'andymass/vim-matchup', event = 'VimEnter'}

  -- Load on a combination of conditions: specific filetypes or commands
  -- Also run code after load (see the "config" key)
  use {
    'w0rp/ale',
    ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
    cmd = 'ALEEnable',
    config = 'vim.cmd[[ALEEnable]]'
  }
  -- You can specify multiple plugins in a single call
  use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}


  -- Use specific branch, dependency and run lua file after load
  use {
    'glepnir/galaxyline.nvim', branch = 'main', config = function() require'statusline' end,
    requires = {'kyazdani42/nvim-web-devicons'}
  }


  use {'neoclide/coc.nvim', branch = 'release'}

  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'


  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
  }

  use {"akinsho/toggleterm.nvim", tag = '*', config = function()
    require("toggleterm").setup{
      size = 20,
      open_mapping = [[<F7>]],
      shade_terminals = false,
      persist_size = true,
      direction = 'horizontal',
    }
  end}

  use('neovim/nvim-lspconfig')
  use('jose-elias-alvarez/null-ls.nvim')
  use('MunifTanjim/prettier.nvim')

  -- You can alias plugin names
  use {'dracula/vim', as = 'dracula'}

  use { 'windwp/nvim-autopairs' }                    -- auto close brackets, etc.

  use { 'Yggdroot/indentLine' }  -- see indentation
  
  use "yuchanns/phpfmt.nvim"

  use "MunifTanjim/nui.nvim"

  use {'stevearc/dressing.nvim'}

  -- use { 
  --   'windwp/nvim-ts-autotag', 
  --   opt = true, 
  --   ft = 'typescriptreact', 
  --   requires = {{'nvim-treesitter/nvim-treesitter'}},
  --   config = function() require('nvim-ts-autotag').setup() end,
  -- }

  -- use ('hrsh7th/nvim-cmp')
  -- use ('hrsh7th/cmp-nvim-lsp')
  -- use ('L3MON4D3/LuaSnip')
  -- use ('saadparwaiz1/cmp_luasnip')
  -- use ("rafamadriz/friendly-snippets")


end)