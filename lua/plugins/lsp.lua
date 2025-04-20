return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "cssls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lsp = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			lsp.lua_ls.setup({
				capabilities = capabilities,
			})

			lsp.ts_ls.setup({
				capabilities = capabilities,
			})

			lsp.cssls.setup({
				capabilities = capabilities,
			})
		end,
	},
}
