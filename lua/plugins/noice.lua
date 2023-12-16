return {
  'folke/noice.nvim',
  dependencies =
  {
    { 'MunifTanjim/nui.nvim' },
    { "rcarriga/nvim-notify" }
  },
  event = 'UIEnter',
  keys = {
    { '<leader>mc', function() require('notify').dismiss() end, desc = "[M]essage [C]lose" },
    { '<leader>mh', vim.cmd.Noice,                              desc = "[M]essage [H]istory" }
  },
  config = function()
    require("noice").setup({
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        hover = { enabled = true },
        signature = { enabled = true },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "search_count",
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
        {
          view = "mini",
          filter = {
            mode = "i",
          },
          opts = { skip = true },
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true,        -- add a border to hover docs and signature help
      },
    })
  end
}
