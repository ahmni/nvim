-- Keybinds

Keymap = vim.api.nvim_set_keymap

Keymap('i', 'jj', '<Esc>', {})

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
vim.keymap.set('n', 'ex', ':Explore<enter>')

vim.keymap.set('n', '<leader>w', ':update<CR>')

-- Buffers
vim.keymap.set('n', '<leader>tn', ':tabnew %<CR>', { desc = "[T]ab [N]ew" })
vim.keymap.set('n', '<leader>tf', ':tabnew ', { desc = "[T]ab New [F]ile" })
vim.keymap.set('n', '<leader>tc', ':tabc<CR>', { desc = "[T]ab [C]lose" })
vim.keymap.set('n', '<leader>to', ':tabo<CR>', { desc = "[T]ab Close [O]thers" })

-- nvim-tree
vim.keymap.set("n", "<leader>ft", ":NvimTreeToggle<cr>")
vim.keymap.set("n", "<leader>ff", ":NvimTreeFindFile<cr>")
vim.keymap.set("n", "<leader>fc", ":NvimTreeCollapse<cr>")

-- nvim-notify
vim.keymap.set('n', '<leader>mc', function () require('notify').dismiss() end, { desc = "[M]essage [C]lose" })

-- custom mappings in init.lua
-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set("", "<space>l", require("lsp_lines").toggle, { desc = "Toggle lsp_lines"})

-- remove trailing sapces on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

