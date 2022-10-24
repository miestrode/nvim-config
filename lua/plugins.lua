local plugin_updates = vim.api.nvim_create_augroup("UpdatePackerFromConfig", {})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "plugins.lua",
	group = plugin_updates,
	callback = function()
		vim.cmd("source <afile> | PackerSync")
	end,
})

-- Automatically install Packer on a new machine
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
end

return require("packer").startup({
	{
		"wbthomason/packer.nvim", -- Allow Packer to manage itself
		{ "neovim/nvim-lspconfig", requires = "williamboman/mason-lspconfig.nvim" },
		{ "williamboman/mason.nvim", requires = { "jayp0521/mason-nvim-dap.nvim", "jayp0521/mason-null-ls.nvim" } },
		{ "catppuccin/nvim", as = "catppuccin" },
		{
			"terrortylor/nvim-comment",
			config = function()
				require("nvim_comment").setup()
			end,
		},
		{
			"folke/noice.nvim",
			event = "VimEnter",
			config = function()
				require("noice").setup({
					notify = {
						enabled = false,
					},
					views = {
						cmdline_popup = {
							position = {
								row = "90%",
								column = "50%",
							},
						},
					},
				})
			end,
			requires = {
				"MunifTanjim/nui.nvim",
				"rcarriga/nvim-notify",
			},
		},
		{
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
		},
		"norcalli/nvim-colorizer.lua",
		"L3MON4D3/LuaSnip",
		{
			"hrsh7th/nvim-cmp",
			requires = {
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lsp-signature-help",
				"kdheepak/cmp-latex-symbols",
			},
		},
		{ "nvim-telescope/telescope-dap.nvim", requires = { "mfussenegger/nvim-dap" } },
		{ "simrat39/rust-tools.nvim", requires = { "nvim-lua/plenary.nvim" } },
		{
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			requires = "nvim-treesitter/playground",
			config = function()
				require("nvim-treesitter.configs").setup({
					playground = {
						enabled = true,
					},
					ensure_installed = "all",
					auto_install = true,
					highlight = { enable = true },
				})
			end,
		},
		{
			"numToStr/FTerm.nvim",
			config = function()
				require("FTerm").setup({ border = "rounded", ft = "Terminal" })
			end,
		},
		{
			"nvim-telescope/telescope.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"kyazdani42/nvim-web-devicons",
				"nvim-telescope/telescope-fzy-native.nvim",
			},
			config = function()
				local telescope = require("telescope")

				telescope.setup()

				telescope.load_extension("fzy_native")
				telescope.load_extension("file_browser")
				telescope.load_extension("dap")
			end,
		},
		{ "nvim-telescope/telescope-file-browser.nvim", requires = "nvim-telescope/telescope.nvim" },
		{ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" },
		"lukas-reineke/indent-blankline.nvim",
		{
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
		},
		{
			"NMAC427/guess-indent.nvim",
			config = function()
				require("guess-indent").setup({})
			end,
		},
		{
			"saecki/crates.nvim",
			event = { "BufRead Cargo.toml" },
			tag = "v0.2.1",
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				require("crates").setup()
			end,
		},
		"stevearc/dressing.nvim",
		{
			"akinsho/git-conflict.nvim",
			tag = "*",
			config = function()
				require("git-conflict").setup()
			end,
		},
		"jose-elias-alvarez/null-ls.nvim",
		{
			"danymat/neogen",
			config = function()
				require("neogen").setup({})
			end,
			requires = "nvim-treesitter/nvim-treesitter",
			tag = "*",
		},
		{
			"folke/todo-comments.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("todo-comments").setup({})
			end,
		},
		{
			"stevearc/qf_helper.nvim",
			config = function()
				require("qf_helper").setup()
			end,
		},
		{
			"ggandor/leap.nvim",
			requires = "tpope/vim-repeat",
			config = function()
				require("leap").set_default_keymaps()
			end,
		},
		"https://gitlab.com/yorickpeterse/nvim-window", -- Easy movement between windows
		{
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup({})
			end,
		},
		"echasnovski/mini.nvim",
	},
	rocks = {},
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
			end,
		},
	},
})
