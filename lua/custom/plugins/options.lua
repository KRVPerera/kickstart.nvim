-- Personal options and keymaps, applied on top of kickstart's defaults in init.lua

vim.o.relativenumber = true
vim.o.scrolloff = 5
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Fold by code structure using Treesitter
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldlevelstart = 99 -- open files with all folds open

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Quickfix list navigation
vim.keymap.set('n', '<a-j>', '<cmd>cnext<CR>', { desc = 'Next quick fix' })
vim.keymap.set('n', '<a-k>', '<cmd>cprev<CR>', { desc = 'Previous quick fix' })
