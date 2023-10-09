return {
  -- LSP
  "onsails/lspkind.nvim",
  'mfussenegger/nvim-jdtls',
  {
    "nvim-treesitter/nvim-treesitter", build = ':TSUpdate',
    event = 'VeryLazy',
    config = function ()
      require'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = { "lua", "vim", 'typescript', 'tsx'},

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
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-tree/nvim-web-devicons'},
      {"smartpde/telescope-recent-files"}
    },
    keys = {
      -- See `:help telescope.builtin`
      { '<leader>?', function () require('telescope.builtin').oldfiles() end, desc = '[?] Find recently opened files' },
      { '<leader><space>', function () require('telescope.builtin').buffers() end, desc = '[ ] Find existing buffers' },
      {
        '<leader>/',
        function()
          -- You can pass additional configuration to telescope to change theme, layout, etc.
          require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
            winblend = 10,
            previewer = false,
          }))
        end,
        desc = '[/] Fuzzily search in current buffer]'
      },
      { '<leader>sf',function () require('telescope.builtin').find_files() end,  desc = '[S]earch [F]iles' },
      { '<leader>sh', function () require('telescope.builtin').help_tags() end,  desc = '[S]earch [H]elp' },
      { '<leader>sw', function () require('telescope.builtin').grep_string() end,  desc = '[S]earch current [W]ord' },
      { '<leader>sg', function () require('telescope.builtin').live_grep() end,  desc = '[S]earch by [G]rep' },
      { '<leader>sd', function () require('telescope.builtin').diagnostics() end,  desc = '[S]earch [D]iagnostics' },
    },
   config = function ()
      require('telescope').setup({
        defaults = vim.tbl_extend(
        "force",
        require('telescope.themes').get_dropdown(), {
          mappings = {
            n = {
              ['<C-k>'] = 'preview_scrolling_right',
              ['<C-f>'] = 'preview_scrolling_left'
            }
          }
        }),
      })
      require("telescope").load_extension("recent_files")
    end
  },
  -- colorscheme
  {
    'rose-pine/neovim',
    lazy = false,
    priority = 1000,
    config = function ()
      vim.cmd [[colorscheme rose-pine]]
    end
  },
  {
    'nvim-lualine/lualine.nvim', dependencies =
    { 'nvim-tree/nvim-web-devicons', opt = true },
    event = 'VeryLazy',
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
  -- Diagnostics
  {
    'folke/noice.nvim', dependencies =
    {
      {'MunifTanjim/nui.nvim'},
      {"rcarriga/nvim-notify"}
    },
    event = 'VeryLazy',
    keys = {
      { '<leader>mc', function () require('notify').dismiss() end, desc = "[M]essage [C]lose" }
    },
    config = function ()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
    end
  },
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
}


