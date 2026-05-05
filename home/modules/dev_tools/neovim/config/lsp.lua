vim.lsp.inlay_hint.enable(true)

local function cfg_common(client, bufnr)
  print("on attach common")
  vim.api.nvim_create_autocmd({ 'TextChangedI' }, {
    buffer = bufnr,
    callback = function()
      vim.lsp.completion.get()
    end
  })
  vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set("n", "<leader>gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "<leader>K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>cd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set('i', '<Down>', function()
    if vim.fn.pumvisible() == 1 then
      return '<C-e><Down>'
    else
      return '<Down>'
    end
  end, { expr = true })
  vim.keymap.set('i', '<Up>', function()
    if vim.fn.pumvisible() == 1 then
      return '<C-e><Up>'
    else
      return '<Up>'
    end
  end, { expr = true })
end

vim.lsp.config("*", {
  on_attach = cfg_common
})

vim.lsp.handlers["$/progress"] = function(_, result, ctx)
  local val = result.value
  if not val.kind then return end
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  if val.kind == "begin" then
    print("🚀 LSP [" .. client.name .. "] starting: " .. val.title)
  elseif val.kind == "end" then
    print("✅ LSP [" .. client.name .. "] done: " .. (val.message or ""))
  end
end

-- Helper for direnv-provided LSPs (only enable if binary is on PATH)
local function enable_if_available(server, opts)
  local cmd = (opts and opts.cmd and opts.cmd[1]) or server
  if vim.fn.executable(cmd) == 1 then
    if opts then vim.lsp.config(server, opts) end
    vim.lsp.enable(server)
  end
end

------------------------------------------------------------
-- Global LSPs (always available via extraPackages)
------------------------------------------------------------
vim.lsp.enable('lua_ls')
vim.lsp.enable('nixd')
vim.lsp.enable('bashls')
vim.lsp.enable('fish_lsp')
vim.lsp.enable('marksman')

------------------------------------------------------------
-- Direnv-provided LSPs (guarded)
------------------------------------------------------------
enable_if_available('rust_analyzer', {
  on_attach = function(client, bufnr)
    cfg_common(client, bufnr)
    print("Overriding rust_analyzer config")
    vim.api.nvim_buf_create_user_command(0, 'LspCargoReload', function()
      reload_workspace(0)
    end, { desc = 'Reload current cargo workspace' })
  end
})

enable_if_available('clangd', {
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'h', 'hpp' }
})

enable_if_available('jdtls', { cmd = { 'jdtls' } })

enable_if_available('gleam')

enable_if_available('cmake', {
  filetypes = { "cmake" },
  rootPatterns = { "build/" },
  initializationOptions = {
    buildDirectory = "build"
  }
})

enable_if_available('pylsp', {
  settings = {
    pylsp = {
      plugins = {
        black = { enabled = true },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        pylint = { enabled = true, executable = "pylint" },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        pylsp_mypy = { enabled = true },
        jedi_completion = { fuzzy = true },
        pyls_isort = { enabled = true },
      },
    },
  }
})

enable_if_available('ansible-language-server', {
  cmd = { 'ansible-language-server', '--stdio' },
  settings = {
    ansible = {
      python = { interpreterPath = 'python' },
      ansible = { path = 'ansible' },
      executionEnvironment = { enabled = false },
      validation = {
        enabled = true,
        lint = { enabled = true, path = 'ansible-lint' },
      },
    },
  },
  filetypes = { 'yaml.ansible' },
  root_markers = { 'ansible.cfg', '.ansible-lint' },
})
