vim.loader.enable()
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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

-- Disable LSP highlighting
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		client.server_capabilities.semanticTokensProvider = nil
	end,
})
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
		{
			"loctvl842/monokai-pro.nvim",
			config = function()
				require("monokai-pro").setup()
				vim.cmd([[colorscheme monokai-pro]])
			end,
		},
		{
			"williamboman/mason.nvim",
			opts = {},
		},
		{
			"williamboman/mason-lspconfig.nvim",
			opts = {
				automatic_enable = false,
				ensure_installed = {
					"lua_ls",
					"marksman",
					"bashls",
					"texlab",
					"rust_analyzer",
					"cmake",
					"clangd",
					"ts_ls",
					"html",
					"svelte",
				},
			},
			dependencies = {
				{ "mason-org/mason.nvim", opts = {} },
				"neovim/nvim-lspconfig",
			},
		},
		{
			"neovim/nvim-lspconfig",
			config = function()
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
				-- require("lspconfig").sourcekit.setup({
				-- 	capabilities = capabilities,
				-- })
				require("lspconfig").marksman.setup({
					capabilities = capabilities,
				})
				require("lspconfig").ts_ls.setup({
					capabilities = capabilities,
					settings = {
						typescript = {
							tsserver = {
								useSyntaxServer = false,
							},
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = true,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayVariableTypeHintsWhenTypeMatchesName = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				})
				require("lspconfig").html.setup({
					capabilities = capabilities,
				})
				require("lspconfig").svelte.setup({
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

				if vim.fn.executable("pyright") == 1 then
					require("lspconfig").pyright.setup({
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
			end,
		},
		{
			"wojciech-kulik/xcodebuild.nvim",
			dependencies = {
				"nvim-telescope/telescope.nvim",
				"MunifTanjim/nui.nvim",
				"folke/snacks.nvim", -- (optional) to show previews
				"nvim-tree/nvim-tree.lua", -- (optional) to manage project files
				"stevearc/oil.nvim", -- (optional) to manage project files
				"nvim-treesitter/nvim-treesitter", -- (optional) for Quick tests support (required Swift parser)
			},
            opts = {},
            cmd = {'XcodebuildPicker'},
			keys = {
				{ "<leader>b", "<cmd>XcodebuildPicker<cr>", desc = "Open picker" },
			},
		},
		{
			"hrsh7th/nvim-cmp",
			-- event = "InsertEnter",
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-nvim-lsp-signature-help",
			},
			config = function()
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
						-- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
						-- ["<C-f>"] = cmp.mapping.scroll_docs(4),
						-- ["<C-Space>"] = cmp.mapping.complete(),
						["<C-e>"] = cmp.mapping.abort(),
						["<Tab>"] = cmp.mapping.confirm({ select = true }),
					}),
					sources = cmp.config.sources({
						{ name = "nvim_lsp" },
					}, {
						{ name = "buffer" },
					}, {
						{ name = "nvim_lsp_signature_help" },
					}),
					experimental = {
						ghost_text = true,
					},
				})

				-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
				cmp.setup.cmdline({ "/", "?" }, {
					mapping = cmp.mapping.preset.cmdline(),
					sources = cmp.config.sources({
						{ name = "buffer" },
					}),
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
			end,
		},
		{
			"akinsho/toggleterm.nvim",
			keys = {
				{ "<leader>t", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
				{ "<leader>t", "<C-\\><C-n><cmd>ToggleTerm<cr>", desc = "Toggle terminal", mode = "t" },
			},
			version = "*",
			opts = {},
		},
		{
			"nvim-tree/nvim-tree.lua",
			keys = {
				{ "<leader>v", "<cmd>NvimTreeToggle<cr>", desc = "Toggle nvim-tree" },
			},
			config = function()
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
			end,
		},
		{
			"nvim-lualine/lualine.nvim",
			dependencies = {
				"nvim-tree/nvim-web-devicons",
			},
			opts = {
				extensions = { "lazy", "nvim-tree" },
				options = {
					theme = "monokai-pro",
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			},
		},
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = true,
		},

		{
			"ggandor/leap.nvim",
			event = "VeryLazy",
			config = function()
				require("leap").create_default_mappings()
			end,
		},
		{
			"numToStr/Comment.nvim",
			event = "VeryLazy",
			opts = {},
		},
		{
			"lewis6991/gitsigns.nvim",
			opts = {
				current_line_blame = true,
				delay = 100,
			},
		},
		{
			"nvim-telescope/telescope.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			keys = {
				{ "<leader>ff", "<cmd>Telescope find_files<cr>" },
				{ "<leader>fg", "<cmd>Telescope live_grep<cr>" },
				{ "<leader>fb", "<cmd>Telescope buffers<cr>" },
				{ "<leader>fh", "<cmd>Telescope help_tags<cr>" },
			},
			opts = {},
		},
		{
			"stevearc/conform.nvim",
			event = "VeryLazy",
			opts = {
				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform will run multiple formatters sequentially
					python = { "black" },
					-- You can customize some of the format options for the filetype (:help conform.format)
					rust = { "rustfmt", lsp_format = "fallback" },
					c = { "clang_format" },
					cpp = { "clang_format" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					svelte = { "prettier" },
					json = { "prettier" },
					-- Conform will run the first available formatter
				},
				-- format_on_save = {
				--     -- These options will be passed to conform.format()
				--     timeout_ms = 500,
				--     lsp_format = "fallback",
				-- },
			},
		},
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			-- lazy = false,
			config = function()
				require("nvim-treesitter.configs").setup({
					modules = {},
					ensure_installed = {},
					ignore_install = {},
					auto_install = true,
					sync_install = false,
					highlight = { enable = true },
					indent = { enable = true },
					incremental_selection = {
						enable = true,
						keymaps = {
							init_selection = "<leader>s",
							node_incremental = "<leader>i",
							node_decremental = "<leader>d",
							scope_incremental = "<leader>c",
						},
					},
				})
			end,
		},
		{
			"quarto-dev/quarto-nvim",
			ft = "quarto",
			dependencies = {
				"jmbuhr/otter.nvim",
				"nvim-treesitter/nvim-treesitter",
			},
			opts = {},
		},
		{

			"gorbit99/codewindow.nvim",
			config = function()
				local codewindow = require("codewindow")
				codewindow.setup({
					auto_enable = true,
					minimap_width = 15,
					screen_bounds = "background",
					window_border = "shadow",
				})
				codewindow.apply_default_keybinds()
			end,
		},
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "monokai-pro" } },
	-- automatically check for plugin updates
	checker = { enabled = false },
})

--- Plugin setup
vim.cmd([[filetype plugin indent on]])

vim.keymap.set("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<cr>")
vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<cr>")
vim.keymap.set("n", "<leader>`", "<cmd>lua vim.lsp.buf.hover()<cr>")
vim.keymap.set("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<cr>")
vim.keymap.set("n", "<leader>g", '<cmd>lua require("conform").format()<cr>')
