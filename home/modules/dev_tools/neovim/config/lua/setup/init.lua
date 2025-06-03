-- Setup default visual stuff
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2

vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.autoindent = true

vim.g.have_nerd_font = true

vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.opt.updatetime = 50
vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.isfname:append("@-@")
vim.opt.iskeyword:append({ "_", "-" })

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.o.completeopt = "menuone,noinsert,noselect,popup,fuzzy"
vim.o.pumheight = 5
