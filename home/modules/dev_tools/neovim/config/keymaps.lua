vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<leader>e', vim.cmd.Ex)
-- Assign visual block to ctrl-q, since it would be in conflict with paste
vim.keymap.set('n', '<c>Q', '<c>v')

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Remove arrow keys. Enforce actual vim navigation in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Treesitter
vim.keymap.set('n', '<leader>it', vim.cmd.InspectTree)

-- Buffer navigation
vim.keymap.set("n", "<leader>n", ":bnext<cr>")
vim.keymap.set("n", "<leader>p", ":bprevious<cr>")
vim.keymap.set("n", "<leader>d", ":bdelete<cr>")

-- LSP completion trigger
vim.keymap.set('i', '<c-space>', function()
  vim.lsp.completion.get()
end)

-- Write template for nix new module
vim.keymap.set('n', '<leader>nxm', function()
  local input = {
    "{pkgs, config, lib, ...}:",
    "let",
    "in",
    "with lib;",
    "{",
    "}"
  }
  local curs_pos = vim.api.nvim_win_get_cursor(0);
  local row = curs_pos[1];
  vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, input)
end)

-- Write .envrc for new project
vim.keymap.set('n', '<leader>envrc', function()
  local input = {
    "use flake",
    "export IN_NIX_SHELL=\"convez#<PROJECT_NAME>\"",
    "export PROJECT_LANGS=$(github-linguist . -j | jq --raw-output 'to_entries|sort_by(.value.percentage)|reverse|map(.key)|@csv|gsub(\"\\\"\";\"\")')"
  }
  local curs_pos = vim.api.nvim_win_get_cursor(0);
  local row = curs_pos[1];
  vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, input)
end)
