-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>w", function() require("conform").format({ async = true, lsp_fallback = false }) end, { desc = "Format with Conform.nvim", silent = true, noremap = true })
vim.keymap.set("n", "\\\\", "gcc", { remap = true, desc = "Toggle comment for line" })
vim.keymap.set("v", "\\\\", "gc", { remap = true, desc = "Toggle comment for line" })
vim.keymap.set("v", "\\\\", "gc", { remap = true, desc = "Toggle comment for line" })

vim.keymap.set("n", "<C-Left>",  "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-Right>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<C-Up>",    "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<C-Down>",  "<C-w>j", { desc = "Move to lower window" })

-- vim.api.nvim_set_keymap("i", "\\<TAB>", "copilot#Accept('<CR>')", {expr=true, silent=true})

