vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set relativenumber")
vim.cmd("set showmode")
vim.cmd("set showmatch")
vim.cmd("set hidden")
-- vim.cmd("hi CursorLineNr guifg=#f000")
vim.cmd("set cursorline")
vim.cmd("set cursorlineopt=number")
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
local modes = { "n", "i", "v" }

vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})
vim.keymap.set("n", "<C-+>", ":vertical resize +10<CR>", {})
vim.keymap.set("n", "<C-è>", ":vertical resize -10<CR>", {})
vim.keymap.set("n", "<leader>e", ":lua vim.diagnostic.open_float()<CR>", {})
vim.keymap.set("n", "<leader>b", ":buffers<CR>:buffer<Space>", {})
vim.keymap.set(modes, "<C-j>", ":m .+1<CR>", {})
vim.keymap.set(modes, "<C-k>", ":m .-2<CR>", {})
vim.keymap.set("n", "<leader><leader>", "<C-w>w", {})
-- tree sitter config
local config = require("nvim-treesitter.configs")

config.setup({
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
})
