return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		depencencies = {
			"nvimtools/none-ls-extras.nvim",
		},
	},
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				require("none-ls.diagnostics.eslint"),
				require("none-ls.code_actions.eslint"),
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
			},
		})
		vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, {})
	end,
}
