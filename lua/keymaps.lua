-- Map Ctrl+j for previous suggestion in Coc.nvim
vim.api.nvim_set_keymap('i', '<C-j>', 'coc#pum#prev(1)', { noremap = true, expr = true })

-- Map Ctrl+k for next suggestion in Coc.nvim
vim.api.nvim_set_keymap('i', '<C-k>', 'coc#pum#next(1)', { noremap = true, expr = true })

-- Map Ctrl+l for accept suggestion in Coc.nvim
vim.api.nvim_set_keymap('i', '<C-o>', 'coc#_select_confirm()', { noremap = true, expr = true })

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
vim.api.nvim_set_keymap("n", "<leader>ee", ":25Lexplore<CR>", { noremap = true, silent = true })

-- Toggle NvimTree with <leader>e and switch focus to it if open, or switch back to the previous buffer if closed
-- vim.api.nvim_set_keymap("n", "<leader>ec", ":Neotree close<CR>", { noremap = true, silent = true })

-- Focus on NvimTree with leader+ft
-- vim.api.nvim_set_keymap("n", "<leader>ft", ":Neotree focus<CR>", { noremap = true, silent = true })

-- Nerd Tree Search with leader+fb
-- vim.api.nvim_set_keymap("n", "<leader>fb", "NERDTreeFind<CR>", { noremap = true, silent = true })



vim.api.nvim_set_keymap('i', '<C-s>',
	'<Esc> :w<CR>:lua retrospect.  SaveSession()<CR>:set autoindent<CR>',
	{ noremap = true, silent = true })


-- Open new file in a new buffer
vim.api.nvim_set_keymap("n", "<leader>n",
	":enew<CR> :lua retrospect.SaveSession()<CR>",
	{ noremap = true, silent = true })


vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- neogit = require('neogit')
vim.keymap.set("n", "<leader>ng", ":Neogit kind=vsplit<CR>")

-- Close current buffer with leader+b+e
vim.api.nvim_set_keymap("n", "<leader>be",
	":bd<CR> :lua retrospect.SaveSession()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>d",
	":bd<CR> :lua retrospect.SaveSession()<CR>", { noremap = true, silent = true })

vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('i', 'kj', '<Esc>')
vim.keymap.set('i', '<C-h>', '<Left>')
vim.keymap.set('i', '<C-l>', '<Right>')
vim.keymap.set('i', '<C-k>', '<Up>')
vim.keymap.set('i', '<C-j>', '<Down>')
vim.keymap.set('i', '<C-b>', '<Esc>bi')
vim.keymap.set('i', '<C-e>', '<Esc>ea')


-- Keybindings for Telescope and ripgrep
vim.api.nvim_set_keymap("n", "<leader>ff", [[<Cmd>Telescope find_files<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fg", [[<Cmd>Telescope live_grep<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fr", [[<Cmd>Telescope resume<CR>]], { noremap = true, silent = true })




-- remap leader+w to save file
vim.api.nvim_set_keymap('n', '<Leader>w',
	':lua retrospect.SaveSession()<CR>:w<CR>:set autoindent<CR>',
	{ noremap = true, silent = true })

-- Create a variable to store the cursor position
vim.g.saved_cursor_position = {}

-- Map Ctrl-y to insert a new line below and return to the exact cursor position
vim.keymap.set('i', '<C-A-j>',
	'<Esc>:let g:saved_cursor_position = getpos(".")<CR>o<Up><Esc>:call setpos(".", g:saved_cursor_position)<CR>a')

-- Map Ctrl-z to insert a new line above and return to the exact cursor position
vim.keymap.set('i', '<C-A-k>',
	'<Esc>:let g:saved_cursor_position = getpos(".")<CR>O<Down><Esc>:let g:saved_cursor_position[1] = g:saved_cursor_position[1] + 1<CR>:call setpos(".", g:saved_cursor_position)<CR>a')




cocInstallString = "coc-html coc-css coc-html-css-support coc-emmet @yaegassy/coc-intelephense coc-tsserver coc-rust-analyzer coc-omnisharp coc-lua coc-json"

vim.cmd("command! CocInstallKar CocInstall " .. cocInstallString)
