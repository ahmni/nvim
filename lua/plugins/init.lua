return {
  -- LSP
  "onsails/lspkind.nvim",
  {
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-buffer'},     -- Required
      {'hrsh7th/cmp-path'},     -- Required
      {'saadparwaiz1/cmp_luasnip'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'hrsh7th/cmp-nvim-lua'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required
    }
  },
  'mfussenegger/nvim-jdtls',
  {"nvim-treesitter/nvim-treesitter", build = ':TSUpdate'},
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-tree/nvim-web-devicons'}
    }
  },
  "smartpde/telescope-recent-files",
  'mbbill/undotree',
  'theprimeagen/harpoon',
  -- Git integration
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'lewis6991/gitsigns.nvim',
  -- colorscheme
  'rose-pine/neovim',
  {
    'nvim-lualine/lualine.nvim', dependencies =
    { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
      require("lualine").setup({
        options = {
          theme = 'auto',
          component_separators = '|',
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = {
            { 'mode', separator = { left = '' }, right_padding = 1 },
          },
          lualine_x = {'filetype', 'fileformat'},
        },
        tabline = {
          lualine_a = {
            {
              'tabs',
              mode = 1,
              fmt = function(name, context)
                -- Show + if buffer is modified in tab
                local buflist = vim.fn.tabpagebuflist(context.tabnr)
                local winnr = vim.fn.tabpagewinnr(context.tabnr)
                local bufnr = buflist[winnr]
                local mod = vim.fn.getbufvar(bufnr, '&mod')
                local file = vim.api.nvim_buf_get_name(bufnr)
                if type(file) == 'string' then
                  file = file:gsub('%%', '%%%%')
                end

                local icon, _ = require('nvim-web-devicons').get_icon(file, vim.fn.expand('#' .. bufnr .. ':e'))
                if icon then
                  return icon .. ' ' .. name .. (mod == 1 and ' ●' or '')
                end

                return name .. (mod == 1 and ' ●' or '')
              end
            }
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {'searchcount', 'selectioncount'},
          lualine_z = {}
        }
      })
    end
  },
  'romainl/vim-cool',
  'nvim-tree/nvim-tree.lua',
  -- Easy commenting out visual blocks
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
  -- Diagnostics
  {"folke/trouble.nvim", dependencies = "nvim-tree/nvim-web-devicons"},
  {'folke/noice.nvim', dependencies =
    {
      {'MunifTanjim/nui.nvim'},
      {"rcarriga/nvim-notify"}
    }
  },
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
}


