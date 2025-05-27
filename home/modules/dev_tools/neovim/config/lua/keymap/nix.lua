-- Write template for nix new module
-- Keymap set in normal mode (n)
-- Responds to <leader>nxm, where leader is whitespace (see init.lua)
-- This will write the following
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
local col = curs_pos[2];
vim.api.nvim_buf_set_lines(0, row - 1,row-1,false, input)
end)

-- Write .envrc for new project
vim.keymap.set('n', '<leader>envrc', function ()
local input = {
	"use flake",
	"export IN_NIX_SHELL=\"convez#<PROJECT_NAME>\"",
	"export PROJECT_LANGS=$(github-linguist . -j | jq --raw-output 'to_entries|sort_by(.value.percentage)|reverse|map(.key)|@csv|gsub(\"\\\"\";\"\")')"
}
local curs_pos = vim.api.nvim_win_get_cursor(0);
local row = curs_pos[1];
local col = curs_pos[2];
vim.api.nvim_buf_set_lines(0, row - 1,row-1,false, input)
end)
