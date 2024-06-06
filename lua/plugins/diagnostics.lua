return {
  "folke/trouble.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  keys = {
    { "<leader>xx", "<cmd>Trouble cascade toggle<cr>",                        desc = "[X] [X] Trouble" },
    { "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>",                    desc = "[X] [W]orkspace " },
    { "<leader>xb", "<cmd>Trouble buffer_and_errors<cr>",       desc = "[B]uffer Diag" },
    { "<leader>xd", "<cmd>Trouble symbols toggle focus=false<cr>",            desc = "[D]ocument Diag" },
    { "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                         desc = "[Q]uick Diag" },
    { "<leader>xl", "<cmd>Trouble loclist toggle<cr>",                        desc = "[L]ocation List" },
    { "gr",         function() require("trouble").open("lsp_references") end, desc = "[G]oto [R]eferences" },
  },
  config = function()
    require("trouble").setup({
      modes = {
        cascade = {
          mode = "diagnostics", -- inherit from diagnostics mode
          filter = function(items)
            local severity = vim.diagnostic.severity.HINT
            for _, item in ipairs(items) do
              severity = math.min(severity, item.severity)
            end
            return vim.tbl_filter(function(item) return item.severity == severity end, items)
          end,
        },
        buffer_and_errors = {
          mode = "diagnostics",
          filter = {
            any = {
              buf = 0,                            -- current buffer
              {
                severity = vim.diagnostic.severity.ERROR, -- errors only
                -- limit to files in the current project
                function(item) return item.filename:find((vim.loop or vim.uv).cwd(), 1, true) end,
              },
            },
          },
        },
      },
    })
  end,
}
