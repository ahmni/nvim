return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  keys = {
    { "<space>l", function() require("lsp_lines").toggle() end, desc = "Toggle lsp_lines" },
  },
  init = function()
    vim.diagnostic.config({
      virtual_text = false,
      virtual_lines = false,
    })
  end,
  config = function()
    require("lsp_lines").setup()
  end,
}
