vim.g.catppuccin_flavour = "macchiato"
require("catppuccin").setup({
	integrations = {
		lsp_trouble = true,
		leap = true,
		dap = {
			enabled = true,
			enable_ui = true,
		},
		mini = true,
	},
})
vim.cmd.colorscheme("catppuccin")

local cp = require("catppuccin.palettes.macchiato")

vim.api.nvim_set_hl(0, "Bulb", { fg = cp.flamingo })

require("statusline")

vim.opt.termguicolors = true
require("bufferline").setup({
	options = { separator_style = "slant" },
	highlights = require("catppuccin.groups.integrations.bufferline").get(),
})

require("startup")

return {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "襁",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "塞",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}
