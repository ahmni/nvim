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
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function() require("nvim-surround").setup({}) end,
  },
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6", --recommended as each new version will have breaking changes
    opts = {
      --Config goes here
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufRead",
    opts = {
      max_lines = 4,
      multiline_threshold = 1,
      mode = "topline",
    },
  },
}
