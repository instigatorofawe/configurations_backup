-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = "\\"
vim.g.maplocalleader = " "

--- Begin settings
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

vim.keymap.set("n", "j", [[gj]])
vim.keymap.set("n", "k", [[gk]])

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

--- End settings

-- Setup lazy.nvim
require("lazy").setup({
	spec = { -- add your plugins here
		"loctvl842/monokai-pro.nvim",

		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
			},
		},
		{
			"akinsho/toggleterm.nvim",
			version = "*",
		},
		"nvim-tree/nvim-tree.lua",
		{
			"nvim-lualine/lualine.nvim",
			dependencies = {
				"nvim-tree/nvim-web-devicons",
			},
		},
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = true,
			-- use opts = {} for passing setup options
			-- this is equivalent to setup({}) function
		},

		-- "m4xshen/autoclose.nvim",
		"ggandor/leap.nvim",
		"numToStr/Comment.nvim",
		"lewis6991/gitsigns.nvim",
		{
			"nvim-telescope/telescope.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
		},
		"stevearc/conform.nvim",
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "monokai-pro" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

--- Plugin setup
-- require('autoclose').setup()
require("toggleterm").setup()

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"marksman",
		"bashls",
		"texlab",
		"rust_analyzer",
		"cmake",
		"clangd",
		"angularls",
		"ts_ls",
	},
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- You can customize some of the format options for the filetype (:help conform.format)
		rust = { "rustfmt", lsp_format = "fallback" },
		c = { "clang_format" },
		cpp = { "clang_format" },
		-- Conform will run the first available formatter
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

require("Comment").setup()
require("gitsigns").setup()
require("leap").create_default_mappings()

require("monokai-pro").setup({})
vim.cmd([[colorscheme monokai-pro]])

local cmp = require("cmp")

cmp.setup({
	snippet = { -- REQUIRED - you must specify a snippet engine
		expand = function(args)
			vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
	}, {
		{ name = "buffer" },
	}),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
	matching = { disallow_symbol_nonprefix_matching = false },
})

-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").lua_ls.setup({
	capabilities = capabilities,

	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})
require("lspconfig").marksman.setup({
	capabilities = capabilities,
})
require("lspconfig").angularls.setup({
	capabilities = capabilities,
})
require("lspconfig").ts_ls.setup({
	capabilities = capabilities,
})
require("lspconfig").bashls.setup({
	capabilities = capabilities,
})
require("lspconfig").texlab.setup({
	capabilities = capabilities,
})
require("lspconfig").clangd.setup({
	capabilities = capabilities,
})
require("lspconfig").cmake.setup({
	capabilities = capabilities,
})
require("lspconfig").rust_analyzer.setup({
	capabilities = capabilities,
	on_attach = function(_, bufnr)
		vim.lsp.inlay_hint.enable(true, { bufnr })
	end,
})

if vim.fn.executable("basedpyright") == 1 then
	require("lspconfig").basedpyright.setup({
		capabilities = capabilities,
		on_attach = function(_, bufnr)
			vim.lsp.inlay_hint.enable(true, { bufnr })
		end,
	})
end

if vim.fn.executable("R") == 1 then
	require("lspconfig").r_language_server.setup({
		capabilities = capabilities,
	})
end

vim.g.nvim_tree_respect_buf_cwd = 1
require("nvim-tree").setup({
	sort = {
		sorter = "case_sensitive",
	},
	view = {
		width = 35,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
})

require("lualine").setup({
	extensions = { "lazy", "nvim-tree" },
	options = { theme = "monokai-pro" },
})

vim.cmd([[filetype plugin indent on]])

vim.keymap.set("n", "<leader>t", ":ToggleTerm<cr>")
vim.keymap.set("n", "<leader>v", ":NvimTreeToggle<cr>")
vim.keymap.set("n", "<leader>r", ":lua vim.lsp.buf.rename()<cr>")

vim.keymap.set("n", "<leader>ff", ":Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<cr>")
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<cr>")
