-- Map Ctrl+j for previous suggestion in Coc.nvim
vim.api.nvim_set_keymap('i', '<C-j>', 'coc#pum#prev(1)', { noremap = true, expr = true })

-- Map Ctrl+k for next suggestion in Coc.nvim
vim.api.nvim_set_keymap('i', '<C-k>', 'coc#pum#next(1)', { noremap = true, expr = true })

-- Map Ctrl+l for accept suggestion in Coc.nvim
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

-- Toggle NvimTree with <leader>e and switch focus to it if open, or switch back to the previous buffer if closed
-- vim.api.nvim_set_keymap("n", "<leader>ec", ":Neotree close<CR>", { noremap = true, silent = true })

-- Focus on NvimTree with leader+ft
-- vim.api.nvim_set_keymap("n", "<leader>ft", ":Neotree focus<CR>", { noremap = true, silent = true })

-- Nerd Tree Search with leader+fb
-- vim.api.nvim_set_keymap("n", "<leader>fb", "NERDTreeFind<CR>", { noremap = true, silent = true })



vim.api.nvim_set_keymap('i', '<C-s>',
	'<Esc> :w<CR>:lua retrospect.SaveSession()<CR>:set autoindent<CR>',
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

vim.keymap.set('n', 'Q', 'q')

-- Keybindings for Telescope and ripgrep
-- vim.api.nvim_set_keymap("n", "<leader>ff", [[<Cmd>lua require("telescope.builtin").find_files({ previewer = false })<CR>]], { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>fg", [[<Cmd>Telescope live_grep<CR>]], { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>fr", [[<Cmd>Telescope resume<CR>]], { noremap = true, silent = true })

-- Keybindings for CtrlP and vimgrep

-- vim.cmd([[set grepprg=rg\ --vimgrep\ --hidden]])


-- fzf = require('fzf-lua')

-- vim.api.nvim_set_keymap("n", "<leader>f", [[<Cmd>CtrlP<CR>]], { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>f", [[<Cmd>FzfLua files<CR>]], { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("i", "<C-f>", [[<Cmd>FzfLua files<CR>]], { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>g", [[<Cmd>FzfLua live_grep_native<CR>]], { noremap = true, silent = true })

vim.keymap.set('n', '<leader>f', ':Leaderf file<CR>')
vim.keymap.set('n', '<leader>g', ':Leaderf rg<CR>')
vim.keymap.set('n', '[', ':Leaderf line<CR>')


-- vim.keymap.set({ "n", "v", "i" }, "<C-x><C-f>",
--   function() require("fzf-lua").complete_path() end,
--   { silent = true, desc = "Fuzzy complete path" })

vim.keymap.set({ "i" }, "<C-x><C-f>",
	function()
		require("fzf-lua").complete_file({
			cmd = "rg --files",
			winopts = { preview = { hidden = "nohidden" } }
		})
	end, { silent = true, desc = "Fuzzy complete file" })

-- vim.api.nvim_set_keymap("n", "<leader>g", "", {
-- 	noremap = true,
-- 	silent = true,
-- 	callback = function()
-- 		vim.cmd([[set grepprg=rg\ --vimgrep\ --smart-case\ --hidden]])
-- 		vim.cmd([[set grepformat=%f:%l:%c:%m]])

-- 		search = vim.fn.input("Enter search term: ")

-- 		-- filetype = vim.fn.input("Enter filetype: ")

-- 		spdir = vim.fn.input("Enter specific directory: ")
-- 		vim.cmd(':silent grep! "' .. search .. '" ' .. spdir .. ' | cope')

-- 		print("Search complete")

-- 		-- vim.cmd(":1000vimgrep /" .. search .. "/j **/*." .. filetype)

-- 		-- open quickfix window
-- 		-- vim.cmd(":copen")
-- 	end
-- })




-- remap leader+w to save file
vim.api.nvim_set_keymap('n', '<Leader>w',
	':lua retrospect.SaveSession()<CR>:w<CR>:set autoindent<CR>',
	{ noremap = true, silent = true })

-- Create a variable to store the cursor position
-- vim.g.saved_cursor_position = {}

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


-- Map Ctrl-j to insert a new line below and return to the exact cursor position
vim.keymap.set('v', '<A-j>',
	'<Esc>:let g:saved_cursor_position = getpos(".")<CR>o<Up><Esc>:call setpos(".", g:saved_cursor_position)<CR>gv')

-- Map Ctrl-k to insert a new line above and return to the exact cursor position
vim.keymap.set('v', '<A-k>',
	'<Esc>:let g:saved_cursor_position = getpos(".")<CR>O<Down><Esc>:let g:saved_cursor_position[1] = g:saved_cursor_position[1] + 1<CR>:call setpos(".", g:saved_cursor_position)<CR>gv')



-- COC

cocInstallString =
"coc-html coc-css coc-html-css-support coc-emmet @yaegassy/coc-intelephense coc-tsserver coc-rust-analyzer coc-omnisharp coc-lua coc-json coc-clangd coc-pyright coc-snippets"

vim.cmd("command! CocInstallKar CocInstall " .. cocInstallString)

vim.keymap.set("n", "<leader>coc", ":Lazy load coc.nvim<CR>")

vim.keymap.set("n", "gd", ":call CocActionAsync('jumpDefinition')<CR>")
vim.keymap.set("n", "K", ":call CocActionAsync('definitionHover')<CR>")

vim.keymap.set("n", "<C-u>", "coc#float#has_scroll() ? coc#float#scroll(1) : '<C-u>'", { silent = true, expr = true })
vim.keymap.set("n", "<C-i>", "coc#float#has_scroll() ? coc#float#scroll(0) : '<C-i>'", { silent = true, expr = true })
vim.keymap.set("i", "<C-u>", "coc#float#has_scroll() ? coc#float#scroll(1) : ''", { silent = true, expr = true })
vim.keymap.set("i", "<C-i>", "coc#float#has_scroll() ? coc#float#scroll(0) : ''", { silent = true, expr = true })


vim.keymap.set("i", "<Tab>", "coc#pum#visible() ? '<Tab>' : '<Tab>'", { expr = true })
