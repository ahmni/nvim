-- Keybinds
vim.keymap.set("i", "jj", "<Esc>", {})

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

vim.keymap.set("v", "<leader>D", '"_d')

vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "[R]eplace Word " })

vim.keymap.set("n", "<space>e", "<cmd>Explore<enter>", { desc = "open [E]xplorer" })

vim.keymap.set("n", "<leader>w", "<cmd>update<CR>", { desc = "[W]rite file" })
-- write without auto-format
vim.cmd("command! W noa w")

vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")

-- LSP
function toggle_virtual_lsp()
  vim.g.virtual_lsp_active = not vim.g.virtual_lsp_active
  vim.diagnostic.config({
    virtual_text = vim.g.virtual_lsp_active,
    underline = vim.g.virtual_lsp_active,
  })
end

vim.keymap.set("n", "<leader>l", "<cmd>lua toggle_virtual_lsp()<cr>", {
  silent = true,
})

vim.keymap.set("n", "<leader>vi", "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) <cr>", {
  silent = true,
})

-- Buffers
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew %<CR>", { desc = "[T]ab [N]ew" })
vim.keymap.set("n", "<leader>te", "<cmd>Texplore<CR>", { desc = "[T]ab New [E]xplorer" })
vim.keymap.set("n", "<leader>ts", "<cmd>Texplore<CR> <cmd> Telescope find_files <CR>", { desc = "[T]ab New [S]earch" })
vim.keymap.set("n", "<leader>tc", "<cmd>tabc<CR>", { desc = "[T]ab [C]lose" })
vim.keymap.set("n", "<leader>to", "<cmd>tabo<CR>", { desc = "[T]ab Close [O]thers" })
