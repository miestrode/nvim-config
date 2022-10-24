require("lualine").setup({
	options = {
		theme = "catppuccin",
		component_separators = "|",
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = {
			{ "mode", separator = { left = "" }, right_padding = 2 },
		},
		lualine_b = { "filename", "branch" },
		lualine_c = { "filesize", "diff" },
		lualine_x = {
			"diagnostics",
		},
		lualine_y = { "filetype", "progress" },
		lualine_z = {
			{ "location", separator = { right = "" }, left_padding = 2 },
		},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = { "filename", "branch" },
		lualine_c = { "filesize", "diff" },
		lualine_x = { "diagnostics" },
		lualine_y = { "filetype", "progress" },
		lualine_z = { { "location", left_padding = 2 } },
	},
	ignore_focus = {},
	tabline = {},
	extensions = {},
})
