vim.opt.completeopt = { "menu", "menuone", "noselect" }
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.loader.enable()

local config = {
  defaults = {
    lazy = true,
  },
  debug = false,
  profiling = {
    loader = false,
    require = false,
  },
}

require("set")
require("keybinds")

require("lazy").setup("plugins", config)
