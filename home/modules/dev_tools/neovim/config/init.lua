print("Starting nvim configuring")
require("keymap")
require("plugin")
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
