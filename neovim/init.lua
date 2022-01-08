
-- set leader to space
vim.g.mapleader = " "

-- enable line numbers
vim.wo.number = true

-- use spaces for tabs, and a width of 4
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- load plugins
require('plugins')

-- set up the gui
require('config.gui')

-- set up treesitter
require('config.treesitter')

-- set up autocomplete/snippets
require('config.completion')

-- set up go (mainly ray-x/go.nvim)
require('config.go')
