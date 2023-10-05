require('mason').setup()
require('mason-lspconfig').setup()

local lsp = require('lsp-zero').preset({
})

lsp.preset("recommended")

--You need to setup `cmp` after lsp-zero
local cmp = require('cmp')

require('luasnip.loaders.from_vscode').lazy_load()

local lspkind = require('lspkind')

lsp.setup_nvim_cmp({
  sources = {
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
  },
  mapping = {
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({ select = true}),
    ['<D-u>'] = cmp.mapping.confirm({ select = true}),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    ['<D-e>'] = cmp.mapping.abort(),

    -- Navigate between snippet placeholder
    ['<D-n>'] = cmp.mapping.select_next_item(),
    ['<D-b>'] = cmp.mapping.select_prev_item(),
  },
  formatting = {
    format = lspkind.cmp_format({
      maxwidth = 100, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
    })
  }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-CR>", function() vim.lsp.buf.signature_help() end, opts)
  -- disable semantic highlighting
  client.server_capabilities.semanticTokensProvider = nil
end)

lsp.skip_server_setup({'jdtls'})

-- Fix undefined globals
require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()


