local builtin = require('telescope.builtin')
local function gitignore()
  local file = io.open(".gitignore", "r")
  local args = {}

  if not file then
    return args
  end

  for line in file:lines() do
    line = vim.trim(line)
    if line ~= '' and not line:match('^#') then
      if not line:match('^!') then
        if line:sub(-1) == '/' then
          line = line .. '*'
        end
        table.insert(args, '--glob')
        table.insert(args, '!' .. line)
      end
    end
  end

  file:close()
  return args
end

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({
    search = vim.fn.input("Grep > "),
    additional_args = vim.list_extend({
      '--hidden',
      '--ignore',
    }, gitignore())
  });
end)
