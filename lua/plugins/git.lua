return {
  {'tpope/vim-fugitive',
    keys = {
      {"<leader>gs", vim.cmd.Git, desc = "[G]it [Status" }
    },
    cmd = 'G'
  },
  {
    'tpope/vim-rhubarb',
    cmd = 'GBrowse',
  },
  {
    event = 'BufRead *.*',
    'lewis6991/gitsigns.nvim',
    config = function ()
      require('gitsigns').setup()
    end
  }
}
