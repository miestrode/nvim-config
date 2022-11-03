local cmp = require("cmp")
local icons = require("theme")
local catpuccin = require("catppuccin.palettes.macchiato")

vim.api.nvim_set_hl(0, "CmpBorder", { fg = catpuccin.blue })

local luasnip = require("luasnip")

cmp.setup({
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = icons[vim_item.kind]

			vim_item.menu = ({
				buffer = "Buffer",
				nvim_lsp = "LSP",
				luasnip = "Snippets",
				nvim_lua = "Lua",
				latex_symbols = "LaTeX",
				dictionary = "Words"
			})[entry.source.name]
			return vim_item
		end,
	},
	enabled = function()
		local context = require("cmp.config.context")
		if vim.api.nvim_get_mode().mode == "c" then
			return true
		else
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
		end
	end,
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered({
			winhighlight = "Normal:BorderFloat,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
		}),
		documentation = cmp.config.window.bordered({
			winhighlight = "Normal:Normal,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
		}),
	},
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping(function(_)
			cmp.mapping.complete()
		end, { "c" }),
		["<C-a>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "latex_symbols" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "luasnip" },
		{
		 	name = "dictionary",
			keyword_length = 2,
		}
	}, {
		{ name = "buffer" },
	}),
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
})

cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
		{ name = "path" },
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

require("cmp_dictionary").setup({
    dic = {
        ["*"] = "/usr/share/dict/words",
	}
})

return require("cmp_nvim_lsp").default_capabilities()
