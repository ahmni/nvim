-- (Optional) Auto-install wbthomason/packer.nvim if it does not exist.
-- See https://github.com/wbthomason/packer.nvim#bootstrapping for instructions.
vim.opt.completeopt = { "menu", "menuone", "noselect" }
local ensure_packer = function()
    local fn = vim.fn
     local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
     if fn.empty(fn.glob(install_path)) > 0 then
       fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
       vim.cmd [[packadd packer.nvim]]
       return true
     end
     return false
  end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- My plugins here
  use("onsails/lspkind.nvim")
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
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
      {'rafamadriz/friendly-snippets'},
    }
  }
  use 'mfussenegger/nvim-jdtls'
  require('lsp')
  use({
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  })
  vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = false,
  })
  use({"nvim-treesitter/nvim-treesitter", run = ':TSUpdate'})
  require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "java", "lua", "vim", "proto", 'typescript', 'javascript'},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/    store/parsers")!

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
    },
  }
  use {"nvim-telescope/telescope.nvim", branch = '0.1.x',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-tree/nvim-web-devicons'}
    }
  }
  use 'theprimeagen/harpoon'
  use 'mbbill/undotree'
  use 'tpope/vim-fugitive'
  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use({"smartpde/telescope-recent-files"})
  -- colorscheme
  -- use {'AlexvZyl/nordic.nvim', config = function() vim.cmd [[colorscheme nordic]] end,}
  -- use {'Shatur/neovim-ayu', config = function() vim.cmd [[colorscheme ayu ]] end,}
  use {'rose-pine/neovim', config = function() vim.cmd [[colorscheme rose-pine ]] end,}
  -- use {'savq/melange-nvim', config = function() vim.cmd [[colorscheme melange ]] end,}
  -- use {'luisiacc/gruvbox-baby', branch = 'main', config = function()
  --   vim.cmd.colorscheme("gruvbox-baby") end }
  use { 'nvim-lualine/lualine.nvim', requires =
  	{ 'nvim-tree/nvim-web-devicons', opt = true },
      config = function()
       require("lualine").setup({ options = { theme = 'auto' } }) end
  }

  -- Diagnostics
  use({ "folke/trouble.nvim", requires = "nvim-tree/nvim-web-devicons"})
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
  require("diagnostics") -- Diagnostics
  require("telescope").load_extension("recent_files")
  require("keybinds")
end)

