return {
  'sbdchd/neoformat',
  cmd = 'Neoformat',
  config = function()
    vim.g.neoformat_run_all_formatters = 1
    vim.g.neoformat_enabled_typescript = { 'prettier', 'eslint_d' }
  end
}
