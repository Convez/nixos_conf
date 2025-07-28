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
    vim.keymap.set("n", "<leader>gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<leader>K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>ca", function () vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>cd", function () vim.diagnostic.open_float() end, opts)
    vim.keymap.set('i', '<Down>', function()
      if vim.fn.pumvisible() == 1 then
        return '<C-e><Down>' -- close the menu, move cursor
      else
        return '<Down>'
      end
    end, { expr = true })


    vim.keymap.set('i', '<Up>', function()
      if vim.fn.pumvisible() == 1 then
        return '<C-e><Up>' -- close the menu, move cursor
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

if(vim.fn.executable('fish-lsp')==1) then
  vim.lsp.enable('fish_lsp')
end

if(vim.fn.executable('gleam')==1) then
  vim.lsp.enable('gleam')
end

if(vim.fn.executable('pylsp')==1) then
  vim.lsp.config('pylsp',{
   settings = {
      pylsp = {
      plugins = {
          -- formatter options
          black = { enabled = true },
          autopep8 = { enabled = false },
          yapf = { enabled = false },
          -- linter options
          pylint = { enabled = true, executable = "pylint" },
          pyflakes = { enabled = false },
          pycodestyle = { enabled = false },
          -- type checker
          pylsp_mypy = { enabled = true },
          -- auto-completion options
          jedi_completion = { fuzzy = true },
          -- import sorting
          pyls_isort = { enabled = true },
      },
      },
    }
  })
    vim.lsp.enable('pylsp')
  end
