-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup({function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- use 'tpope/vim-dadbod'
  -- use 'kristijanhusak/vim-dadbod-ui'

  -- use { "catppuccin/nvim", as = "catppuccin" }

  use 'folke/tokyonight.nvim'

  -- Simple plugins can be specified as strings
  use {'rstacruz/vim-closer', cond=false} -- disable closer

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
  -- use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}


  use {'neoclide/coc.nvim', branch = 'release'}

  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'

  use 'mbbill/undotree'

  use 'tpope/vim-fugitive'

  use 'tpope/vim-surround'

  use 'AndrewRadev/tagalong.vim'


  -- use {
  --   'nvim-tree/nvim-tree.lua',
  --   requires = {
  --     'nvim-tree/nvim-web-devicons', -- optional
  --   },
  -- }

  use {
    'preservim/nerdtree',
      requires = {
        'ryanoasis/vim-devicons', -- optional
      },
  }

  use {"akinsho/toggleterm.nvim", tag = '*', config = function()
    require("toggleterm").setup{
      size = 20,
      open_mapping = [[<F7>]],
      shade_terminals = false,
      persist_size = true,
      direction = 'float',
    }
  end}

  -- use('neovim/nvim-lspconfig')
  -- use('jose-elias-alvarez/null-ls.nvim')
  --  use('MunifTanjim/prettier.nvim')

  use { 'cohama/lexima.vim' }                    -- auto close brackets, etc.

  use { 'Yggdroot/indentLine' }  -- see indentation
  

  use "MunifTanjim/nui.nvim"

  use {'stevearc/dressing.nvim'}

  use 'tpope/vim-commentary'

end,config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}})
