local lspconfig = require('lspconfig')

local function has_bin(bin)
  return vim.fn.executable(bin) == 1
end

local M = {}

M.setup = function()
  if has_bin("typescript-language-server") then
    lspconfig.tsserver.setup({})
    print("TypeScript LSP is set up")
  end

  if has_bin("pyright") then
    lspconfig.pyright.setup({})
    print("Python LSP is set up")
  end

  if has_bin("rust-analyzer") then
    lspconfig.rust_analyzer.setup({})
    print("Rust Analyzer is set up")
  end

  if has_bin("java") then
    lspconfig.jdtls.setup({})
    print("Java LSP is set up")
  end
  -- Add more LSPs here...
end

return M
