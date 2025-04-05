return {
	"ggandor/leap.nvim",
	enabled = true,
	keys = {
		{ "s", mode = { "n", "x", "o" }, desc = "Leap Forward to" },
		{ "S", mode = { "n", "x", "o" }, desc = "Leap Backward to" },
		{ "gs", mode = { "n", "x", "o" }, desc = "Leap from Windows" },
	},
	config = function(_, opts)
		local leap = require("leap")
		leap.setup({
			case_sensitive = false,
			special_keys = {
				next_target = "<CR>",
				prev_target = "<S-CR>",
				next_group = "<Space>",
				prev_group = "<S-Space>",
				multi_accept = "<CR>",
				multi_revert = "<S-CR>",
			},
			highlight_unlabeled = false,
			max_phase_one_targets = 10,
			max_highlighted_traversal_targets = 10,
		})
		leap.add_default_mappings(true)
		vim.keymap.del({ "x", "o" }, "x")
		vim.keymap.del({ "x", "o" }, "X")
	end,
}
