local opt = vim.opt

-- Indentazione
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

-- Numeri di riga
opt.number = true
opt.relativenumber = true

-- UI
opt.showmode = true
opt.showmatch = true
opt.cursorline = true
opt.cursorlineopt = "number"

-- Comportamento
opt.hidden = true

-- Leader key
vim.g.mapleader = " "
