local packer = require("packer")

local setup = function (use)
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    requires = {{ 'nvim-lua/plenary.nvim'}}
  }
  use 'direnv/direnv.vim'
  -- use 'neovim/nvim-lspconfig'
  use 'mfussenegger/nvim-jdtls'
  use 'ThePrimeagen/vim-be-good'
  
  -- Colorschemes
  use 'Shatur/neovim-ayu'
  use 'sts10/vim-pink-moon'
  use 'rose-pine/neovim'

end

packer.startup(setup)