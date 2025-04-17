local modes = { "n", "i", "v" }

-- File explorer
vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", { desc = "Toggle file explorer" })

-- Resize windows
vim.keymap.set("n", "<C-+>", ":vertical resize +10<CR>", { desc = "Increase window width" })
vim.keymap.set("n", "<C-è>", ":vertical resize -10<CR>", { desc = "Decrease window width" })

-- Diagnostics
vim.keymap.set("n", "<leader>e", ":lua vim.diagnostic.open_float()<CR>", { desc = "Show diagnostics" })

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