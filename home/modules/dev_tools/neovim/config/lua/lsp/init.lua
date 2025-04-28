vim.o.completeopt = "menu,noselect,popup,fuzzy"
vim.lsp.inlay_hint.enable(true)
local function cfg_common(client,bufrn)
    print("on attach common")
    vim.api.nvim_create_autocmd({'TextChangedI'}, {
      buffer = bufrn,
      callback = function()
        vim.lsp.completion.get()
      end
    })
    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true})
    local opts = {buffer = bufnr, remap = false}
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
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
  elseif val.kind == "report" then
    print("📡 LSP [" .. client.name .. "] progress: " .. (val.message or ""))
  elseif val.kind == "end" then
    print("✅ LSP [" .. client.name .. "] done: " .. (val.message or ""))
  end
end


if(vim.fn.executable('lua-language-server')==1) then
  vim.lsp.enable('lua_ls')
end

if(vim.fn.executable('rust-analyzer')==1) then
  vim.lsp.config("rust_analyzer", {
    on_attach = function(client,bufrn)
        cfg_common(client,bufrn)
        print("Overriding rust_analyzer config")
        vim.api.nvim_buf_create_user_command(0, 'LspCargoReload', function()
        reload_workspace(0)
      end, { desc = 'Reload current cargo workspace' })
    end
  })
  vim.lsp.enable('rust_analyzer')
end

if(vim.fn.executable('nixd')==1) then
  vim.lsp.enable('nixd')
end

if(vim.fn.executable('jdtls')==1) then
  vim.lsp.config("java_language_server", {
    cmd = {'jdtls'}
  })
  vim.lsp.enable('java_language_server')
end

