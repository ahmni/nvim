return {
  'sbdchd/neoformat',
  cmd = 'Neoformat',
  config = function()
    vim.g.neoformat_try_node_exe       = 1
    vim.g.neoformat_enabled_typescript = { 'prettier' }
  end
}
