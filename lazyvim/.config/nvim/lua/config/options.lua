-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = false

vim.o.shiftwidth = 2 -- sets shiftwidth globally
vim.o.tabstop = 2 -- sets tab width globally
vim.o.expandtab = true

-- Disable recommended style settings for specific languages
vim.g.python_recommended_style = 0
vim.g.rust_recommended_style = 0

vim.o.wrap = true
vim.o.linebreak = true
vim.g.autoformat = false
