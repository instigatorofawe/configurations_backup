vim.keymap.set("n", "j", [[gj]])
vim.keymap.set("n", "k", [[gk]])

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

vim.keymap.set("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<cr>")
vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<cr>")
vim.keymap.set("n", "<leader>`", "<cmd>lua vim.lsp.buf.hover()<cr>")
vim.keymap.set("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<cr>")
vim.keymap.set("n", "<leader>g", '<cmd>lua require("conform").format()<cr>')