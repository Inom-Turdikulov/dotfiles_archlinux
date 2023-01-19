vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.expand('~/.vim/undodir')
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- Custom highlighting in diff mode
vim.opt.diffopt:append { 'linematch:50' }

-- Support cyrillic keyboard layout (colemak-dh -> йцукен)
vim.opt.langmap = "ФЕЧСЛУПЬДНТГРОЖЕЙЫВАШМЦЯЩИ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фечслупьднтгрожейывашмцящи;abcdefghijklmnopqrstuvwxyz"

-- Enable syntax highlight in code blocks
vim.g.markdown_fenced_languages = {'python', 'cpp', 'javascript'}

