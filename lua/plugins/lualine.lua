return {
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
}
