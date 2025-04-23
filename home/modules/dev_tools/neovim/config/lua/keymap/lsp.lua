vim.keymap.set('i', '<c-space>', function()
  print("try get completion")
  vim.lsp.completion.get()
end)
