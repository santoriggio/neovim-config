local opt = vim.opt

-- Ottimizzazioni generali
opt.updatetime = 100
opt.timeoutlen = 500
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.clipboard = "unnamedplus"
opt.undofile = true
opt.pumheight = 10
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.splitbelow = true
opt.splitright = true
opt.wrap = false
opt.list = true
opt.listchars = { tab = "→ ", trail = "·" }
opt.fillchars = {
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
}

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

-- Lingua
vim.cmd("language en_US")

-- Leader key
vim.g.mapleader = " "
