return {
	{
		"github/copilot.vim",
		event = "BufRead",
		cmd = "Copilot",
	},
	-- {
	--   "zbirenbaum/copilot.lua",
	--   cmd = "Copilot",
	--   event = "InsertEnter",
	--   config = function()
	--     require("copilot").setup({
	--       suggestion = {
	--         auto_trigger = true,
	--         keymap = {
	--           accept = "<Tab>",
	--           next = "<D-[",
	--         },
	--       },
	--     })
	--   end,
	-- },
}
