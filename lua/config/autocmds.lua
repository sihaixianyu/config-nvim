-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local helix_parity = vim.api.nvim_create_augroup("helix_parity", { clear = true })

-- Like Helix, reveal the diagnostic for the current line in a separate popup
-- after the cursor settles, without moving focus away from the source buffer.
vim.opt.updatetime = 300
vim.api.nvim_create_autocmd("CursorHold", {
  group = helix_parity,
  callback = function()
    vim.diagnostic.open_float(nil, {
      scope = "cursor",
      focus = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    })
  end,
})

-- Match languages.toml: JSON uses two spaces, the other configured languages use four.
vim.api.nvim_create_autocmd("FileType", {
  group = helix_parity,
  pattern = { "json", "jsonc" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- Markdown is prose-heavy: keep highlighting, but disable spell checking and
-- diagnostics so ordinary text and embedded snippets are not marked red.
vim.api.nvim_create_autocmd("FileType", {
  group = helix_parity,
  pattern = { "markdown", "markdown.mdx" },
  callback = function(args)
    vim.opt_local.spell = false
    vim.diagnostic.enable(false, { bufnr = args.buf })
  end,
})
