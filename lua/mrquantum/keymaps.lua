vim.g.mapleader = " ";
vim.g.netrw_banner    = 0   -- gets rid of the annoying banner for netrw

vim.keymap.set("n", "<leader>w", ":w<CR>:lua retrospect.SaveSession()<CR>");
vim.keymap.set("i", "jk", "<Esc>");
vim.keymap.set("i", "kj", "<Esc>");
vim.keymap.set("n", "<leader>e", vim.cmd.Ex);
vim.keymap.set("n", "<leader>d", vim.cmd.bd);

-- Map Ctrl-j to insert a new line below and return to the exact cursor position
vim.keymap.set('i', '<A-j>',
	'<Esc>:let g:saved_cursor_position = getpos(".")<CR>o<Up><Esc>:call setpos(".", g:saved_cursor_position)<CR>a')

-- Map Ctrl-k to insert a new line above and return to the exact cursor position
vim.keymap.set('i', '<A-k>',
	'<Esc>:let g:saved_cursor_position = getpos(".")<CR>O<Down><Esc>:let g:saved_cursor_position[1] = g:saved_cursor_position[1] + 1<CR>:call setpos(".", g:saved_cursor_position)<CR>a')

-- Map Ctrl-j to insert a new line below and return to the exact cursor position
vim.keymap.set('n', '<A-j>',
	'<Esc>:let g:saved_cursor_position = getpos(".")<CR>o<Up><Esc>:call setpos(".", g:saved_cursor_position)<CR>')

-- Map Ctrl-k to insert a new line above and return to the exact cursor position
vim.keymap.set('n', '<A-k>',
	'<Esc>:let g:saved_cursor_position = getpos(".")<CR>O<Down><Esc>:let g:saved_cursor_position[1] = g:saved_cursor_position[1] + 1<CR>:call setpos(".", g:saved_cursor_position)<CR>')


-- Map Ctrl+o for accept suggestion in Coc.nvim
vim.api.nvim_set_keymap('i', '<C-o>', "coc#pum#visible() ? coc#_select_confirm() : '<C-o>'",
	{ noremap = true, expr = true })

-- Function to show or refresh Coc suggestion list
function ShowOrRefreshCocList()
	if vim.fn.pumvisible() == 1 then
		return vim.fn['coc#refresh']()
	else
		return vim.fn['coc#complete']()
	end
end

-- Map Ctrl+Space to show or refresh Coc suggestion list
vim.api.nvim_set_keymap('i', '<C-e>', 'coc#refresh()', { noremap = true, expr = true })


-- Toggle NvimTree with <leader>e and switch focus to it if open, or switch back to the previous buffer if closed
-- See plugins_lazy
-- vim.api.nvim_set_keymap("n", "<leader>ee", ":Neotree float<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>e", "", {
	noremap = true,
	silent = true,
	callback = function()
		filesearch = vim.fn.expand("%:t")
		-- print(":25Vex<CR>:call search('" .. filesearch .. "')<CR>")
		-- vim.cmd(":25Vex")
		vim.cmd(":Ex")
		vim.cmd(":call search('" .. filesearch .. "')")
	end
})


vim.api.nvim_set_keymap('i', '<C-s>',
	'<Esc> :w<CR>:lua retrospect.SaveSession()<CR>',
	{ noremap = true, silent = true })


-- Open new file in a new buffer
vim.api.nvim_set_keymap("n", "<leader>n",
	":enew<CR> :lua retrospect.SaveSession()<CR>",
	{ noremap = true, silent = true })

vim.keymap.set('n', 'Q', 'q')


-- vim.keymap.set('n', '<leader>f', ':Leaderf file<CR>')
-- -- vim.keymap.set('n', '<leader>g', ':Leaderf rg<CR>')
-- vim.keymap.set('n', '=', ':Leaderf line<CR>')
vim.keymap.set("n", "<leader>f", ":Pick files tool='git'<CR>")
vim.keymap.set("n", "<leader>r", ":Pick files tool='rg'<CR>")
vim.keymap.set("n", "<leader>g", ":Pick grep<CR>")

vim.cmd([[set grepprg=rg\ --vimgrep\ --hidden]])

vim.api.nvim_set_keymap("n", "<leader>p", "", {
	noremap = true,
	silent = true,
	callback = function()
		vim.cmd([[set grepprg=rg\ --vimgrep\ --smart-case\ --hidden]])
		vim.cmd([[set grepformat=%f:%l:%c:%m]])

		search = vim.fn.input("Enter search term: ")
		if search == "" then
			return
		end

		-- filetype = vim.fn.input("Enter filetype: ")

		spdir = vim.fn.input("Enter specific directory: ")
		vim.cmd(':silent grep! "' .. search .. '" ' .. spdir .. ' | cope')

		print("Search complete")

		-- vim.cmd(":1000vimgrep /" .. search .. "/j **/*." .. filetype)

		-- open quickfix window
		-- vim.cmd(":copen")
	end
})


cocInstallString =
"coc-html coc-css coc-html-css-support coc-emmet @yaegassy/coc-intelephense coc-tsserver coc-rust-analyzer coc-omnisharp coc-lua coc-json coc-clangd coc-pyright coc-snippets"

vim.cmd("command! CocInstallKar CocInstall " .. cocInstallString)


vim.keymap.set("n", "<C-u>", "coc#float#has_scroll() ? coc#float#scroll(1) : '<C-u>'", { silent = true, expr = true })
vim.keymap.set("n", "<C-i>", "coc#float#has_scroll() ? coc#float#scroll(0) : '<C-i>'", { silent = true, expr = true })
vim.keymap.set("i", "<C-u>", "coc#float#has_scroll() ? coc#float#scroll(1) : ''", { silent = true, expr = true })
vim.keymap.set("i", "<C-i>", "coc#float#has_scroll() ? coc#float#scroll(0) : ''", { silent = true, expr = true })


-- Remap Alt+Shift+F to format using Coc
vim.api.nvim_set_keymap('n', '<A-S-F>', [[:call CocActionAsync('format')<CR>]], { noremap = true, silent = true })



vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('i', 'kj', '<Esc>')
vim.keymap.set('i', '<C-h>', '<Left>')
vim.keymap.set('i', '<C-l>', '<Right>')
vim.keymap.set('i', '<C-k>', '<Up>')
vim.keymap.set('i', '<C-j>', '<Down>')
vim.keymap.set('i', '<C-b>', '<Esc>bi')
vim.keymap.set('i', '<C-e>', '<Esc>ea')


vim.keymap.set('n', '<C-h>', ':lua require("bufferchad").nav_to_marked(1)<CR>')
vim.keymap.set('n', '<C-j>', ':lua require("bufferchad").nav_to_marked(2)<CR>')
vim.keymap.set('n', '<C-k>', ':lua require("bufferchad").nav_to_marked(3)<CR>')
vim.keymap.set('n', '<C-l>', ':lua require("bufferchad").nav_to_marked(4)<CR>')


vim.keymap.set("i", "<Tab>", "coc#pum#visible() ? '<Tab>' : '<Tab>'", { expr = true })


-- remap arrow keys to resize windows
vim.keymap.set('n', '<Up>', ':resize -2<CR>')
vim.keymap.set('n', '<Down>', ':resize +2<CR>')
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>')
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>')