local modes = { "n", "i", "v" }

-- File explorer
vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", { desc = "Toggle file explorer" })

-- Resize windows
vim.keymap.set("n", "<C-+>", ":vertical resize +10<CR>", { desc = "Increase window width" })
vim.keymap.set("n", "<C-è>", ":vertical resize -10<CR>", { desc = "Decrease window width" })

-- Diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic details" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Show diagnostic list" })

-- LSP
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentation" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Show references" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
-- vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
-- vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })

-- Buffers
vim.keymap.set("n", "<leader>b", ":buffers<CR>:buffer<Space>", { desc = "List buffers" })

-- Move lines
vim.keymap.set(modes, "<C-j>", ":m .+1<CR>", { desc = "Move line down" })
vim.keymap.set(modes, "<C-k>", ":m .-2<CR>", { desc = "Move line up" })

-- Window navigation
vim.keymap.set("n", "<leader><leader>", "<C-w>w", { desc = "Switch windows" })

-- Copy relative path
vim.api.nvim_create_user_command("Crp", function()
	local path = vim.fn.expand("%:p:.")
	vim.fn.setreg("+", path)
	vim.notify("Copied relative path: " .. path)
end, {})

vim.keymap.set("n", "<leader>rp", ":Crp<CR>", { desc = "Copy relative path" })
