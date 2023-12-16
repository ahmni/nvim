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

vim.keymap.set('n', '<space>e', '<cmd>Explore<enter>')

vim.keymap.set('n', '<leader>w', '<cmd>update<CR>')

vim.keymap.set('t', '<ESC>', '<C-\\><C-n>')

-- Buffers
vim.keymap.set('n', '<leader>tn', '<cmd>tabnew %<CR>', { desc = "[T]ab [N]ew" })
vim.keymap.set('n', '<leader>te', '<cmd>Texplore<CR>', { desc = "[T]ab New [E]xplorer" })
vim.keymap.set('n', '<leader>ts', '<cmd>Texplore<CR> <cmd> Telescope find_files <CR>', { desc = "[T]ab New [S]earch" })
vim.keymap.set('n', '<leader>tc', '<cmd>tabc<CR>', { desc = "[T]ab [C]lose" })
vim.keymap.set('n', '<leader>to', '<cmd>tabo<CR>', { desc = "[T]ab Close [O]thers" })
vim.keymap.set('n', 'H', 'gt', { desc = "go to left tab" })
vim.keymap.set('n', 'F', 'gT', { desc = "go to right tab" })

-- remove trailing sapces on save
--vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--  pattern = { "*" },
--  command = [[%s/\s\+$//e]],
--})
