print('Setting keymap for nix')
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
local row, col = unpack(vim.api.nvim_win_get_cursor(0))
vim.api.nvim_buf_set_lines(0, row - 1,row-1,false, input)
end)