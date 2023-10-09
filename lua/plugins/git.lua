return {
  {'tpope/vim-fugitive', lazy = false,
    keys = {
      {"<leader>gs", vim.cmd.Git, desc = "[G]it [Status" }
    }
  },
  {
    'tpope/vim-rhubarb',
    cmd = 'GBrowse',
  },
  {
    event = 'BufEnter',
    'lewis6991/gitsigns.nvim',
    config = function ()
      require('gitsigns').setup()
    end
  }
}
