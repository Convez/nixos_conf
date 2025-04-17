local packer = require("packer")

local setup = function (use)
  use 'direnv/direnv.vim'
  use 'neovim/nvim-lspconfig'
  use 'mfussenegger/nvim-jdtls'
  use 'ThePrimeagen/vim-be-good'
end

packer.startup(setup)