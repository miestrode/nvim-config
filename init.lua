-- Plugin independent configuration
require("plugins")

-- Remaining setup
require("theme")
require("languages")

-- Some key-value configuration
vim.cmd([[
set noshowmode
set number
set tabstop=4
set shiftwidth=4
set expandtab
set autochdir
set completeopt=menu,menuone,noselect
]])
