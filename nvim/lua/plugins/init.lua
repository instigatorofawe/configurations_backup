return {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000},
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
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<C-Tab>", "<cmd>BufferLineCycleNext<CR>", mode = "n" },
			{ "<C-S-Tab>", "<cmd>BufferLineCyclePrev<CR>", mode = "n" },
		},
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				mode = "tabs",
			},
		},
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
				theme = "catppuccin",
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
		"ggandor/leap.nvim",
		keys = {
			{ "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
			{ "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
		},
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
		"nvim-pack/nvim-spectre",
		dependencies = {
			"nvim-lua/plenary.nvim",
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
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
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
		event = "BufReadPost",
		config = function()
			local codewindow = require("codewindow")
			codewindow.setup({
				auto_enable = true,
				minimap_width = 10,
				screen_bounds = "background",
				window_border = "shadow",
			})
			codewindow.apply_default_keybinds()
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
}
