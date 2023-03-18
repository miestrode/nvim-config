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

require("rust-tools").setup({
	server = {
		on_attach = on_attach,
		capabilities = capabilities,
        settings = {
            cargo = {
                target = "x86_64-unknown-linux-gnu"
            }
        }
	},
})

local lsp_config = require("lspconfig")

require("lspconfig").ltex.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)

		require("ltex_extra").setup({
			load_langs = { "en-US" },
			init_check = true,
			path = nil,
			log_level = "none",
		})
	end,
	settings = {
		ltex = {
			completionEnabled = true,
			checkFrequency = "save",
		},
	},
})

local function setup_langs(languages)
	for language, settings in pairs(languages) do
		lsp_config[language].setup({ on_attach = on_attach, capabilities = capabilities, settings = settings })
	end
end

local languages = {
	pyright = {},
    jdtls = {},
	texlab = {
		texlab = {
			build = {
				onSave = true,
				executable = "tectonic",
				args = {
					"-X",
					"compile",
					"%f",
				},
			},
		},
	},
	lua_ls = {
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
}

setup_langs(languages)

local null = require("null-ls")

require("mason-null-ls").setup({
	automatic_installation = true,
})

local formatting = null.builtins.formatting

null.setup({
	sources = { formatting.prettierd, formatting.black, formatting.stylua },
})
