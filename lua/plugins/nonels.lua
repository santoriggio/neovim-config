return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				require("none-ls.diagnostics.eslint").with({
					diagnostics_format = "[eslint] #{m}",
					condition = function(utils)
						return utils.root_has_file({
							".eslintrc",
							".eslintrc.js",
							".eslintrc.json",
							".eslintrc.yml",
							".eslintrc.yaml",
						})
					end,
				}),
				require("none-ls.code_actions.eslint").with({
					condition = function(utils)
						return utils.root_has_file({
							".eslintrc",
							".eslintrc.js",
							".eslintrc.json",
							".eslintrc.yml",
							".eslintrc.yaml",
						})
					end,
				}),
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end,
		})
		vim.keymap.set("n", "<leader>f", function()
			vim.lsp.buf.format { async = true }
		end, {})
	end,
}

