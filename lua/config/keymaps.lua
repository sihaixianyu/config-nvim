-- General
vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })
vim.keymap.set({ "n", "x", "o" }, "mm", "%", { desc = "Go to matching bracket" })

-- Goto
vim.keymap.set({ "n", "x" }, "gg", "gg", { desc = "Go to file start" })
vim.keymap.set({ "n", "x" }, "ge", "G", { desc = "Go to file end" })
vim.keymap.set({ "n", "x" }, "gh", "0", { desc = "Go to line start" })
vim.keymap.set({ "n", "x" }, "gl", "$", { desc = "Go to line end" })
vim.keymap.set({ "n", "x" }, "gs", "^", { desc = "Go to line first non-blank" })

-- Buffer
vim.keymap.set("n", "gn", "]b", { remap = true, desc = "Go to next buffer" })
vim.keymap.set("n", "gp", "[b", { remap = true, desc = "Go to prev buffer" })

-- LSP
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>d", function()
  vim.diagnostic.open_float(nil, { scope = "cursor", focus = false })
end, { desc = "Show line diagnostic" })
vim.keymap.set("n", "<leader>k", function()
  vim.api.nvim_set_hl(0, "LspHoverBorder", { fg = "#ffff00", bold = true, nocombine = true })
  vim.lsp.buf.hover()
end, { desc = "Show language server hover" })
