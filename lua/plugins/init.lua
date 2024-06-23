return {
	{
		"romainl/vim-cool",
		event = "BufRead",
	},
	{
		"otavioschwanck/arrow.nvim",
		event = "BufRead",
		opts = {
			show_icons = true,
			leader_key = ";", -- Recommended to be a single key
			separate_by_branch = true,
			buffer_leader_key = "m",
		},
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function() require("nvim-surround").setup() end,
	},
	-- {
	--   "sourcegraph/sg.nvim",
	--   dependencies = {
	--     "nvim-lua/plenary.nvim",
	--     "nvim-telescope/telescope.nvim",
	--   },
	--   event = "BufRead",
	--   config = function()
	--     require("sg").setup({
	--       enable_cody = false,
	--     })
	--   end,
	-- },
	-- Speedtyping minigame :)
	-- {
	-- 	"NStefan002/speedtyper.nvim",
	-- 	cmd = "Speedtyper",
	-- 	opts = {},
	-- },
}
