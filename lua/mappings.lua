vim.g.mapleader = " "

local function map_key_with_leader(mode, key, result, options)
	vim.keymap.set(mode, "<leader>" .. key, result, options)
end

local fterm = require("FTerm")

map_key_with_leader("n", "e", "<cmd>TroubleToggle<cr>", {}) -- Toggle the pretty error list
vim.keymap.set("t", "<A-t>", fterm.toggle, {})
vim.keymap.set("n", "<A-t>", fterm.toggle, {})
vim.keymap.set("n", "<A-k>", "ddkPk<cr>")
vim.keymap.set("n", "<A-j>", "ddpk<cr>")
map_key_with_leader("n", "fs", "<cmd>Telescope find_files<cr>", {})
map_key_with_leader("n", "t", "<cmd>Telescope<cr>", {})
map_key_with_leader("n", "p", "<cmd>Telescope project<cr>", {})
map_key_with_leader("n", "ff", "<cmd>Telescope current_buffer_fuzzy_find<cr>", {})

vim.keymap.set("n", "<A-s>", require("mini.starter").open, {})

-- Keybindings for Neogen, used for generating documentation
map_key_with_leader("n", "dd", require("neogen").generate, {})
map_key_with_leader("n", "df", '<cmd>lua require("neogen").generate {type = "func"}<cr>', {})
map_key_with_leader("n", "ds", '<cmd>lua require("neogen").generate {type = "class"}<cr>', {})
map_key_with_leader("n", "dg", '<cmd>lua require("neogen").generate {type = "file"}<cr>', {})

map_key_with_leader("n", "w", require("nvim-window").pick, {})
map_key_with_leader("n", "h", "<cmd>BufferLinePick<cr>", {})
map_key_with_leader("n", "c", "<cmd>BufferLinePickClose<cr>", {})
map_key_with_leader("n", "b", "<cmd>Telescope file_browser<cr>", {})

return function(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	map_key_with_leader("n", "sd", vim.lsp.buf.definition, bufopts)
	map_key_with_leader("n", "sh", vim.lsp.buf.hover, bufopts)
	map_key_with_leader("n", "si", vim.lsp.buf.implementation, bufopts)
	map_key_with_leader("n", "st", vim.lsp.buf.type_definition, bufopts)
	map_key_with_leader("n", "sr", vim.lsp.buf.rename, bufopts)
	map_key_with_leader("n", "sc", vim.lsp.buf.code_action, bufopts)
	map_key_with_leader("v", "sc", vim.lsp.buf.code_action, bufopts)
	map_key_with_leader("n", "sl", vim.lsp.codelens.run, bufopts)
	map_key_with_leader("n", "sf", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
	map_key_with_leader("n", "ss", "<cmd>Telescope lsp_workspace_symbols<cr>", bufopts)

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		update_in_insert = true,
	})
end
