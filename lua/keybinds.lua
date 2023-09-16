-- Keybinds

Keymap = vim.api.nvim_set_keymap
vim.g.mapleader = " "

Keymap('i', 'jj', '<Esc>', {})

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('x', '<leader>p', '\"_dP')

vim.keymap.set('n', '<leader>y', '\"+y')
vim.keymap.set('v', '<leader>y', '\"+y')
vim.keymap.set('n', '<leader>y', '\"+Y')

vim.keymap.set('n', '<leader>d', '\"_d')
vim.keymap.set('v', '<leader>d', '\"_d')

vim.keymap.set("n", "<leader>f", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>',
{})
vim.keymap.set('n', 'ex', ':Explore<enter>')

vim.keymap.set('n', '<leader>w', ':update<CR>')

-- Trouble mappings
vim.keymap.set("n", "<leader>x", function() require("trouble").open() end)
vim.keymap.set("n", "<leader>xc", function() require("trouble").close() end)
vim.keymap.set("n", "<leader>xw", function() require("trouble").open("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() require("trouble").open("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() require("trouble").open("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() require("trouble").open("loclist") end)
vim.keymap.set("n", "gR", function() require("trouble").open("lsp_references") end)

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
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>jf', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ")});
end)

-- remove trailing sapces on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})
