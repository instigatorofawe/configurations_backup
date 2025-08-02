vim.loader.enable()

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

vim.g.mapleader = "\\"
vim.g.maplocalleader = " "

vim.opt.clipboard = "unnamedplus"

vim.opt.cursorline = true
vim.opt.colorcolumn = "80,120"
vim.opt.textwidth = 120
vim.opt.ruler = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wildmenu = true
vim.opt.lazyredraw = true
vim.opt.showmatch = true

vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		client.server_capabilities.semanticTokensProvider = nil
	end,
})

vim.cmd([[filetype plugin indent on]])