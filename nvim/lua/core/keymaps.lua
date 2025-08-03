vim.keymap.set("n", "j", [[gj]])
vim.keymap.set("n", "k", [[gk]])

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

vim.keymap.set("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<cr>")
vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<cr>")
vim.keymap.set("n", "<leader>`", "<cmd>lua vim.lsp.buf.hover()<cr>")
vim.keymap.set("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<cr>")
vim.keymap.set("n", "<leader>g", '<cmd>lua require("conform").format()<cr>')

-- Close all hidden buffers
vim.keymap.set("n", "<leader>x", function()
  local visible_bufs = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    visible_bufs[vim.api.nvim_win_get_buf(win)] = true
  end
  
  local closed_count = 0
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and not visible_bufs[buf] then
      vim.api.nvim_buf_delete(buf, {})
      closed_count = closed_count + 1
    end
  end
  
  print("Closed " .. closed_count .. " hidden buffers")
end, { desc = "Delete hidden buffers" })