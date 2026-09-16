-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Keep the editing experience aligned with ~/.config/helix/config.toml.
local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.cursorline = true
opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.termguicolors = true
opt.signcolumn = "yes"

-- Helix uses four spaces by default; JSON is overridden to two in autocmds.lua.
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
