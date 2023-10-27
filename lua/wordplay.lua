local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

keymapWhich = "visual"

map("i", "'", "''<left>")
map("i", "\"", "\"\"<left>")
map("i", "`", "``<left>")
map("i", "(", "()<left>")
map("i", "[", "[]<left>")
map("i", "{", "{}<left>")


-- map('v', "\"", ':s/\%V\(.*\)\%V/"\1"/')


-- Define the Lua functions for visual mode and visual line mode
function setVisualModeKeymaps()
	keymapWhich = "visual"

	map("v", "'", "c''<ESC>P")
	map("v", "\"", "c\"\"<Esc>P")
	map("v", "`", "c``<Esc>P")
	map("v", "(", "c()<Esc>P")
	map("v", "[", "c[]<Esc>P")
	map("v", "{", "c{}<Esc>P")
end

function setVisualLineModeKeymaps()
	keymapWhich = "visualLine"

	map("x", "'", "c'\n'<Esc>P")
	map("x", "\"", "c\"\n\"<Esc>P")
	map("x", "`", "c`\n`<Esc>P")
	map("x", "(", "c(\n)<Esc>P")
	map("x", "[", "c[\n]<Esc>P")
	map("x", "{", "c{\n}<Esc>P")
end

-- set regular visual mode keymaps on every mode change
vim.api.nvim_create_autocmd('ModeChanged', {
	callback = function()
		if keymapWhich ~= "visual" then
			setVisualModeKeymaps()
		end
	end
})

vim.api.nvim_set_keymap('n', 'V', '', {
	noremap = true,
	silent = true,
	callback = function()
		vim.cmd.execute("'normal! V'")
		setVisualLineModeKeymaps()
	end
})

setVisualModeKeymaps()

-- Visual Maps
map("v", "<leader>r", "\"hy:%s/<C-r>h//g<left><left>") -- Replace all instances of highlighted words
map("v", "<C-s>", ":sort<CR>")                         -- Sort highlighted text in visual mode with Control+S


-- Move selected lines down in visual mode and visual line mode
map("x", "J", ":move '>+1<CR>gv=gv")

-- Move selected lines up in visual mode and visual line mode
map("x", "K", ":move '<-2<CR>gv=gv")