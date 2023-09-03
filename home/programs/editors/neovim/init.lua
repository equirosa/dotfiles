-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
-- remaps that don't work for now
local nmap = function(keys, func, desc)
	if desc then
		desc = "LSP: " .. desc
	end

	vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
end

nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")

require('boole').setup({ -- Config boole.nvim
	mappings = {
		increment = '<C-a>',
		decrement = '<C-x>'
	},
	-- User defined loops
	--[[ additions = {
          {'Foo', 'Bar'},
          {'tic', 'tac', 'toe'}
        }, ]]
	allow_caps_additions = {
		{ 'enable', 'disable' }
		-- enable → disable
		-- Enable → Disable
		-- ENABLE → DISABLE
	}
})
