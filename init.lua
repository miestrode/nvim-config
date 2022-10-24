-- Plugin independent configuration
require("plugins")

-- Remaining setup
require("theme")
require("languages")

-- Some key-value configuration
vim.cmd([[
set noshowmode
set number
set tabstop=4
set shiftwidth=4
set expandtab
set autochdir
set completeopt=menu,menuone,noselect
]])

local services = { vim.lsp.codelens.refresh }
local service_group = vim.api.nvim_create_augroup("ServiceGroup", {})
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
	group = service_group,
	callback = function()
		for _, service in next, services do
			service()
		end
	end,
})
