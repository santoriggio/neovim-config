return {
	"m4xshen/autoclose.nvim",
	config = function()
		require("autoclose").setup({
			options = {
				disabled_filetypes = { "TelescopePrompt", "nofile" },
				disable_when_touch = true,
				pairspairs = {
					{ "(", ")" },
					{ "[", "]" },
					{ "{", "}" },
					{ '"', '"' },
					{ "'", "'" },
					{ "`", "`" },
				},
			},
		})
	end,
}
