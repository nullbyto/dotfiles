-- Imports
require("nullbyto/options")
require("nullbyto/keymaps")

-- Bootstraping lazy.nvim
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

-- Importing plugins
require("lazy").setup("nullbyto.plugins", {})

vim.cmd.colorscheme "tokyonight"
