local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "[A]dd File" })
vim.keymap.set("n", "<leader>q", ui.toggle_quick_menu, { desc = "[Q]uick Menu" })

vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end, { desc = "[1]st File" })
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end, { desc = "[2]nd File" })
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end, { desc = "[3]rd File" })
vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end, { desc = "[4]th File" })
