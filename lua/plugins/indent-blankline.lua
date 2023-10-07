return {
  "lukas-reineke/indent-blankline.nvim", main = "ibl", opts =
  {
    indent = {
      char = "│",
    },
  },
  config = function ()
    require("ibl").setup({
      indent = {
        char = "│"
      },
      scope = {highlight = 'Label'}
    })
  end
}

