return {
  {
    'VonHeikemen/lsp-zero.nvim',
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
      -- Allow noice to control float border
      vim.g.lsp_zero_ui_float_border = 0
    end
  },
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    config = true
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'L3MON4D3/LuaSnip' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { "onsails/lspkind.nvim" },
    },
    config = function()
      local lsp = require('lsp-zero')
      lsp.extend_cmp()
      local cmp = require('cmp')

      local lspkind = require('lspkind')

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        sources = cmp.config.sources(
          {
            { name = 'path' },
            { name = 'nvim_lsp' },
            { name = "nvim_lsp_signature_help" },
          },
          {
            { name = 'buffer' },
          }
        ),
        mapping = {
          -- `Enter` key to confirm completion
          ['<CR>'] = cmp.mapping.confirm({ select = true }),

          -- Ctrl+Space to trigger completion menu
          ['<C-Space>'] = cmp.mapping.complete(),

          ['<C-e>'] = cmp.mapping.abort(),

          -- Navigate between snippet placeholder
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-b>'] = cmp.mapping.select_prev_item(),
        },
        formatting = {
          format = lspkind.cmp_format({
            maxwidth = 100,        -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          })
        }
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional
    },
    config = function()
      local lsp = require('lsp-zero')
      lsp.extend_lspconfig()

      lsp.on_attach(function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }
        -- esLint AutoFormatting
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
          command = "EslintFixAll",
        })

        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
        vim.keymap.set("n", "go", function() vim.lsp.buf.type_definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("i", "<C-CR>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "gs", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
        -- disable semantic highlighting
        -- client.server_capabilities.semanticTokensProvider = nil
      end)

      lsp.format_on_save({
        format_opts = {
          async = false,
          timeout_ms = 10000,
        },
        servers = {
          ['clangd'] = { 'cpp', 'c' },
          ['lua_ls'] = { 'lua' }
        }
      })

      require('mason-lspconfig').setup({
        handlers = {
          lsp.default_setup,
          -- Fix undefined Globals
          lua_ls = function()
            local lua_opts = lsp.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
          end,
        }
      })
    end
  },
  { 'mfussenegger/nvim-jdtls', event = 'BufRead *.java' },
}
