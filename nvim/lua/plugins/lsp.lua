return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
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
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})
			vim.lsp.enable("lua_ls")

			vim.lsp.enable("clangd")
			vim.lsp.enable("marksman")

			vim.lsp.config("ts_ls", {
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
			vim.lsp.enable("ts_ls")

			vim.lsp.enable("html")
			vim.lsp.enable("svelte")
			vim.lsp.enable("bashls")
			vim.lsp.enable("texlab")
			vim.lsp.enable("cmake")

			vim.lsp.config("rust_analyzer", {
				on_attach = function(_, bufnr)
					vim.lsp.inlay_hint.enable(true, { bufnr })
				end,
			})
			vim.lsp.enable("rust_analyzer")

			if vim.fn.executable("pyright") == 1 then
				vim.lsp.config("pyright", {
					on_attach = function(_, bufnr)
						vim.lsp.inlay_hint.enable(true, { bufnr })
					end,
				})
				vim.lsp.enable("pyright")
			end

			if vim.fn.executable("R") == 1 then
				vim.lsp.enable("r_language_server")
			end
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		event = "InsertEnter",
	},
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		event = "LspAttach",
		config = function()
			require("lsp_lines").setup()
			-- Disable virtual_text since lsp_lines will handle diagnostics
			vim.diagnostic.config({
				virtual_text = false,
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				window = {},
				mapping = cmp.mapping.preset.insert({
					["<C-e>"] = cmp.mapping.abort(),
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "luasnip" },
				}, {
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

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "buffer" },
				}),
			})

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
}
