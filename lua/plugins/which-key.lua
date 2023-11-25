return {
  "folke/which-key.nvim",
  event = 'BufEnter',
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    local presets = require("which-key.plugins.presets")
    presets.operators["v"] = nil
    presets.operators["v"] = nil
    require("which-key").setup()
  end
}
