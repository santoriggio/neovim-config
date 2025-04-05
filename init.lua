vim.cmd("language en_US")

-- Ottimizzazioni generali
vim.opt.updatetime = 100
vim.opt.timeoutlen = 300
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.pumheight = 10
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 1
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wrap = false
vim.opt.list = true
vim.opt.listchars = { tab = "→ ", trail = "·" }
vim.opt.fillchars = {
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
}

-- Configurazioni di base
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set relativenumber")
vim.cmd("set nu rnu")
vim.cmd("set showmode")
vim.cmd("set showmatch")
vim.cmd("set hidden")
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
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	change_detection = {
		notify = false,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

local modes = { "n", "i", "v" }

-- Mappature
vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})
vim.keymap.set("n", "<C-+>", ":vertical resize +10<CR>", {})
vim.keymap.set("n", "<C-è>", ":vertical resize -10<CR>", {})
vim.keymap.set("n", "<leader>e", ":lua vim.diagnostic.open_float()<CR>", {})
vim.keymap.set("n", "<leader>b", ":buffers<CR>:buffer<Space>", {})
vim.keymap.set(modes, "<C-j>", ":m .+1<CR>", {})
vim.keymap.set(modes, "<C-k>", ":m .-2<CR>", {})
vim.keymap.set("n", "<leader><leader>", "<C-w>w", {})
vim.keymap.set("n", "<leader>rp", ":Crp<CR>", {})

-- Comando personalizzato
vim.api.nvim_create_user_command("Crp", function()
	local path = vim.fn.expand("%:p:.")
	vim.fn.setreg("+", path)
	vim.notify("Copied relative path: " .. path)
end, {})

-- Tree sitter config
local config = require("nvim-treesitter.configs")
config.setup({
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = true },
})
