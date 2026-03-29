return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		opts = {
			flavour = "mocha",
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {
			scope = {
				enabled = true,
				highlight = { "Function", "Label" },
			},
		},
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
	{ "akinsho/git-conflict.nvim", version = "*", config = true },
	{
		"nvim-tree/nvim-tree.lua",
		keys = {
			{
				"<leader>v",
				function()
					local api = require("nvim-tree.api")
					if api.tree.is_visible() then
						api.tree.close()
					else
						local current_file = vim.fn.expand("%:p")
						if current_file ~= "" then
							local file_dir = vim.fn.fnamemodify(current_file, ":h")
							api.tree.open()
							api.tree.change_root(file_dir)
							api.tree.find_file(current_file)
						else
							api.tree.open()
						end
					end
				end,
				desc = "Toggle nvim-tree",
			},
		},
		opts = {
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
				dotfiles = false,
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			extensions = { "lazy", "nvim-tree" },
			options = {
				theme = "catppuccin-mocha",
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
		config = function()
			local npairs = require("nvim-autopairs")
			npairs.setup({
				disable_filetype = { "TelescopePrompt" },
			})

			-- Disable triple quote pairing for Python
			local Rule = require("nvim-autopairs.rule")
			npairs.add_rules({
				Rule('"""', '"""', "python"):with_pair(function()
					return false
				end),
			})
		end,
	},
	{
		"https://codeberg.org/andyg/leap.nvim",
		config = function()
			vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
			vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
			vim.keymap.set("n", "gs", "<Plug>(leap-from-window)")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			current_line_blame = true,
			current_line_blame_opts = {
				delay = 100,
			},
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
		event = { "BufWritePre", "BufNewFile" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				rust = { "rustfmt", lsp_format = "fallback" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				svelte = { "prettier" },
				json = { "prettier" },
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
                auto_install = true
            })
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
	},
	{
		"lewis6991/satellite.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			bigfile = { enabled = true },
			-- dashboard = { enabled = true },
			-- explorer = { enabled = true },
			-- indent = { enabled = true },
			input = { enabled = true },
			-- picker = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			-- scope = { enabled = true },
			-- scroll = { enabled = true },
			-- statuscolumn = { enabled = true },
			-- words = { enabled = true },
		},
	},
}
