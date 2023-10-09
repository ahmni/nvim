return {
  'nvim-tree/nvim-tree.lua',
  config = function ()
    require('nvim-tree').setup({
      renderer = {
        special_files = {},
        icons = {
          show = {
            folder_arrow = false,
          },
          glyphs = {
            default = "",
            folder = {
              default = "",
              open = "",
              empty = "",
              empty_open = "",
            },
          },
        },
      }
    })
  end,
  cmd = "NvimTreeToggle",
}
