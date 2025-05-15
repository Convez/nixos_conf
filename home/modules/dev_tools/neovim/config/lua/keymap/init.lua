vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<leader>e', vim.cmd.Ex)
-- Assign visual block to ctrl-q, since it would be in conflict with paste
vim.keymap.set('n', '<c>Q', '<c>v')





-- Remove arrow keys. Enforce actual vim navigation in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')



require("keymap.nix")
require("keymap.buffer")
require("keymap.lsp")
