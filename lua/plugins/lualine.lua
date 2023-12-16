return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies =
    { 'nvim-tree/nvim-web-devicons', opt = true },
    event = 'UIEnter',
    config = function()
      require("lualine").setup({
        options = {
          theme = 'auto',
          component_separators = '|',
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = {
            { 'mode', right_padding = 1 },
          },
          lualine_b = {
            'branch', 'diff', 'diagnostics'
          },
          lualine_c = {
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            {
              'filename',
              path = 1,
              symbols = {
                modified = '●', -- Text to show when the file is modified.
                readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
                unnamed = '', -- Text to show for unnamed buffers.
                newfile = '[New]', -- Text to show for newly created file before first write
              },
              fmt = function(str)
                --- @type string
                local fn = vim.fn.expand("%:~:.")

                if vim.startswith(fn, "jdt://") then
                  return fn:gsub("?.*$", "")
                end
                return str
              end,
            }
          },
          lualine_x = {
            {
              require("noice").api.status.command.get,
              cond = require("noice").api.status.command.has,
              color = { fg = "#f6c177" },
            },
            'fileformat',
          },
        },
        -- tabline = {
        --   lualine_a = {
        --     {
        --       'tabs',
        --       mode = 1,
        --       max_length = vim.o.columns / 2,
        --       show_modified_status = false,
        --       tabs_color = {
        --         active = 'lualine_a_normal',
        --         inactive = 'lualine_a_inactive',
        --       },
        --       fmt = function(name, context)
        --         -- Show + if buffer is modified in tab
        --         local buflist = vim.fn.tabpagebuflist(context.tabnr)
        --         local winnr = vim.fn.tabpagewinnr(context.tabnr)
        --         local bufnr = buflist[winnr]
        --         local mod = vim.fn.getbufvar(bufnr, '&mod')
        --         local icon, _ = require('nvim-web-devicons').get_icon_by_filetype(vim.bo.filetype)
        --         if icon then
        --           return icon .. ' ' .. name .. (mod == 1 and ' ●' or '')
        --         end

        --         return name .. (mod == 1 and ' ●' or '')
        --       end
        --     }
        --   },
        --   lualine_b = {},
        --   lualine_c = {},
        --   lualine_x = {},
        --   lualine_y = { 'searchcount', 'selectioncount' },
        --   lualine_z = {}
        -- }
      })
    end
  },
  {
    {
      'akinsho/bufferline.nvim',
      event = 'BufRead',
      version = "*",
      dependencies = 'nvim-tree/nvim-web-devicons',
      config = function()
        require("bufferline").setup {
          options = {
            mode = "tabs",
            always_show_bufferline = false,
            diagnostics = "nvim_lsp",
            diagnostics_indicator = function(count, level, _, context)
              if context.buffer:current() then return '' end

              local icon = level:match("error") and " " or " "
              return " " .. icon .. count
            end,
            separator_style = "slant",
            close_icon = ""
          }
        }
      end,
    }
  }
}
