-- Keybinds
vim.keymap.set('i', 'jj', '<Esc>', {})

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('x', '<leader>p', '\"_dP')

vim.keymap.set('n', '<leader>y', '\"+y')
vim.keymap.set('v', '<leader>y', '\"+y')
vim.keymap.set('n', '<leader>Y', '\"+Y')

vim.keymap.set('n', '<leader>d', '\"_d')
vim.keymap.set('v', '<leader>d', '\"_d')

vim.keymap.set("n", "<leader>f", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', {})
vim.keymap.set('n', 'ex', '<cmd>Explore<enter>')

vim.keymap.set('n', '<leader>w', '<cmd>update<CR>')

-- Buffers
vim.keymap.set('n', '<leader>tn', '<cmd>tabnew %<CR>', { desc = "[T]ab [N]ew" })
vim.keymap.set('n', '<leader>tf', ':tabnew ', { desc = "[T]ab New [F]ile" })
vim.keymap.set('n', '<leader>tc', '<cmd>tabc<CR>', { desc = "[T]ab [C]lose" })
vim.keymap.set('n', '<leader>to', '<cmd>tabo<CR>', { desc = "[T]ab Close [O]thers" })

-- nvim-tree
vim.keymap.set("n", "<leader>ft", "<cmd>NvimTreeToggle<cr>")
vim.keymap.set("n", "<leader>ff", "<cmd>NvimTreeFindFile<cr>")
vim.keymap.set("n", "<leader>fc", "<cmd>NvimTreeCollapse<cr>")

-- remove trailing sapces on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

