local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "rounded"
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local on_attach = require("mappings")
local capabilities = require("completion")

require("mason").setup({
	ui = {
		border = "rounded",
		icons = {
			package_installed = "",
			package_pending = "",
			package_uninstalled = "",
		},
	},
	max_concurrent_installers = 10,
})
require("mason-lspconfig").setup({
	ensure_installed = { "rust_analyzer" },
	automatic_installation = true,
})
require("mason-null-ls").setup({
	automatic_installation = true,
})
require("mason-nvim-dap").setup({
	automatic_installation = true,
})

local extension_path = vim.env.HOME .. "./local/share/nvim/mason/packages/codelldb/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

require("rust-tools").setup({
	server = {
		on_attach = on_attach,
		capabilities = capabilities,
	},
	dap = {
		adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
	},
})

require("haskell-tools").setup({
	hls = { on_attach = on_attach, capabilities = capabilities, settings = { formattingProvider = "fourmolu" } },
})

local lsp_config = require("lspconfig")

local function setup_langs(languages)
	for language, settings in pairs(languages) do
		lsp_config[language].setup({ on_attach = on_attach, capabilities = capabilities, settings = settings })
	end
end

local languages = {
	pyright = {},
	texlab = {
		texlab = {
			build = {
				onSave = true,
				executable = "tectonic",
				args = {
					"-X",
					"compile",
					"%f",
					"--synctex",
					"--keep-logs",
					"--keep-intermediates",
				},
			},
		},
	},
	sumneko_lua = {
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
			format = { enable = false }, -- Formatting is taken care of by StyLua
		},
	},
	taplo = {},
	yamlls = {},
	marksman = {},
	ltex = {
		ltex = {
			ltex.completionEnabled = true,
			checkFrequency = "save"
		}
	},
}

setup_langs(languages)

local null = require("null-ls")
local formatting = null.builtins.formatting
local diagnostics = null.builtins.diagnostics

null.setup({
	sources = { formatting.prettierd, formatting.black, formatting.stylua, diagnostics.alex },
})
