return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.lint_ignore_pattern = { "node_modules/*", "build/*" }
			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				css = { "stylua" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", {
				clear = true,
			})

			-- Lint su eventi comuni, posticipato con vim.schedule
			vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					vim.schedule(function()
						lint.try_lint()
					end)
				end,
			})

			-- Lint dopo conform.nvim format
			vim.api.nvim_create_autocmd("User", {
				pattern = "ConformFormatDone",
				group = lint_augroup,
				callback = function(args)
					vim.schedule(function()
						lint.try_lint(args.buf)
					end)
				end,
			})

			-- Diagnostic settings
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = false,
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")

			conform.setup({
				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
					stop_after_first = true,
				},
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "prettierd", "prettier" },
					typescript = { "prettierd", "prettier" },
					javascriptreact = { "prettierd", "prettier" },
					typescriptreact = { "prettierd", "prettier" },
					json = { "prettierd", "prettier" },
					css = { "stylua", "prettierd", "prettier" },
				},
			})

			vim.keymap.set("n", "<leader>f", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				})
			end)
		end,
	},
}
