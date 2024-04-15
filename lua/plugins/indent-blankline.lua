return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		indent = {
			char = "│",
		},
	},
	event = "BufRead",
	config = function()
		require("ibl").setup({
			indent = {
				char = "│",
			},
			scope = { highlight = "Label" },
		})
	end,
}
