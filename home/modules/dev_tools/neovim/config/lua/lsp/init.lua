vim.o.completeopt = "menu,noselect,popup,fuzzy"
vim.lsp.inlay_hint.enable(true)
local function cfg_common(client,bufrn)
    print("on attach common")
    -- Here I enable completition, but not auto triggering. At least for now.
    -- Maybe autotrigger but with a scrolling popup?
    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true})
    local opts = {buffer = bufnr, remap = false}
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
end
vim.lsp.config("*", {
  on_attach = cfg_common 
})

vim.lsp.config("rust_analyzer", {
  on_attach = function(client,bufrn)
      cfg_common(client,bufrn)
      print("Overriding rust_analyzer config")
      vim.api.nvim_buf_create_user_command(0, 'LspCargoReload', function()
      reload_workspace(0)
    end, { desc = 'Reload current cargo workspace' })
  end
})
vim.lsp.enable('lua_ls')
vim.lsp.enable('rust_analyzer')
-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(args)
--     ---[[Code required to activate autocompletion and trigger it on each keypress
--     local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
--     client.server_capabilities.completionProvider.triggerCharacters = vim.split(".", "")
--     vim.api.nvim_create_autocmd({ 'TextChangedI' }, {
--       buffer = args.buf,
--       callback = function()
--         vim.lsp.completion.get()
--       end
--     })
--     vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
--     ---]]
-- 
--     ---[[Code required to add documentation popup for an item
--     local _, cancel_prev = nil, function() end
--     vim.api.nvim_create_autocmd('CompleteChanged', {
--       buffer = args.buf,
--       callback = function()
--         cancel_prev()
--         local info = vim.fn.complete_info({ 'selected' })
--         local completionItem = vim.tbl_get(vim.v.completed_item, 'user_data', 'nvim', 'lsp', 'completion_item')
--         if nil == completionItem then
--           return
--         end
--         _, cancel_prev = vim.lsp.buf_request(args.buf,
--           vim.lsp.protocol.Methods.completionItem_resolve,
--           completionItem,
--           function(err, item, ctx)
--             if not item then
--               return
--             end
--             local docs = (item.documentation or {}).value
--             local win = vim.api.nvim__complete_set(info['selected'], { info = docs })
--             if win.winid and vim.api.nvim_win_is_valid(win.winid) then
--               vim.treesitter.start(win.bufnr, 'markdown')
--               vim.wo[win.winid].conceallevel = 3
--             end
--           end)
--       end
--     })
--     ---]]
--   end
-- })
