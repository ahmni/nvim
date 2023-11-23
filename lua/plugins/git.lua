return {
  {
    'tpope/vim-fugitive',
    keys = {
      { "<leader>gs", vim.cmd.Git,             desc = "[G]it [S]tatus" },
      { "<leader>gd", "<cmd>Gvdiffsplit!<cr>", desc = "[G]it [D]iff" },
      { "gf",         "<cmd>diffget //2<cr>",  desc = "[G]it [Status" },
      { "gh",         "<cmd>diffget //3<cr>",  desc = "[G]it [Status" },
    },
    dependencies = {
      'tpope/vim-rhubarb',
    },
    cmd = 'G'
  },
  {
    event = 'BufRead',
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }
}
