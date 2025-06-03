local packer = require("packer")

local setup = function (use)
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    requires = {{ 'nvim-lua/plenary.nvim'}}
  }
  use 'direnv/direnv.vim'
  use 'neovim/nvim-lspconfig'
  use 'mfussenegger/nvim-jdtls'
  use 'ThePrimeagen/vim-be-good'
  use 'vuciv/golf'
  
  -- Colorschemes
  use 'Shatur/neovim-ayu'
  use 'sts10/vim-pink-moon'
  use 'rose-pine/neovim'
	use '~/workspace/nvim_randbg'

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'nvim-treesitter/playground'
  
  use 'mbbill/undotree'
  -- Git integration in vim
  use 'tpope/vim-fugitive'
end

packer.startup(setup)
