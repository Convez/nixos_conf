local builtin = require('telescope.builtin')
print("Starting telescope config")
local function gitignore()
  local gitignore = vim.fn.getcwd() .. './gitignore'
  local file = io.open(".gitignore", "r")
  local args = {} 
  
  if not file then
    return args
  end

  for line in file:lines() do
    -- Trim whitespace
    line = vim.trim(line)

    -- Skip blank lines and comments
    if line ~= '' and not line:match('^#') then
      -- Skip negated patterns (those starting with "!")
      if not line:match('^!') then
        -- Ensure directories end with a wildcard
        if line:sub(-1) == '/' then
          line = line .. '*'
        end
        table.insert(args, '--glob')
        table.insert(args, '!' .. line)
      end
    end
  end

  file:close()
  print("Gitignore args: ", vim.inspect(args))
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
      } , gitignore())
  });
end)