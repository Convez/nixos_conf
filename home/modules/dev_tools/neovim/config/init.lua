print("Starting nvim configuring")
-- Setup default visual stuff
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
require("keymap")
require("plugin")

vim.lsp.enable('lua_ls')
vim.lsp.enable('rust_analyzer')
-- require("lsp").setup()
--[[ vim.api.nvim_create_autocmd("User", {
  pattern = "DirenvExported",
  callback = function()
    vim.cmd("LspStop")
    -- Reload your LSPs
    require("lsp").setup()
    print("Direnv updated env; LSPs reloaded.")
  end,
}) ]]
