vim.keymap.set('i', '<c-space>', function()
  vim.lsp.completion.get()
end)
