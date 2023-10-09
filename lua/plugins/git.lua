return {
  {'tpope/vim-fugitive',
    keys = {
      {"<leader>gs", vim.cmd.Git, desc = "[G]it [Status" }
    },
    dependencies = {
      'tpope/vim-rhubarb',
    },
    cmd = 'G'
  },
  {
    event = 'BufRead *.*',
    'lewis6991/gitsigns.nvim',
    config = function ()
      require('gitsigns').setup()
    end
  }
}
