return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 350,
				ignore_whitespace = true,
				virt_text_priority = 100,
			},
		})
	end,
}
