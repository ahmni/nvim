return {
  'theprimeagen/harpoon',
  keys = {
    {"<leader>a", function () require("harpoon.mark").add_file() end,  desc = "[A]dd File" },
    {"<leader>q", function () require("harpoon.ui").toggle_quick_menu() end,  desc = "[Q]uick Menu" },
    { "<leader>1", function() require("harpoon.ui").nav_file(1) end,  desc = "[1]st File" },
    { "<leader>2", function() require("harpoon.ui").nav_file(2) end,  desc = "[2]nd File" },
    { "<leader>3", function() require("harpoon.ui").nav_file(3) end,  desc = "[3]rd File" },
    { "<leader>4", function() require("harpoon.ui").nav_file(4) end,  desc = "[4]th File" }
  },
  dependencies = 'nvim-lua/plenary.nvim'
}
