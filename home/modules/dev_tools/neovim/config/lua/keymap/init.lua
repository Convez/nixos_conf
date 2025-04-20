print("Staring keymap config")
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set('n', '<leader>e', ":Ex<CR>")
require("keymap.nix")
require("keymap.buffer")
