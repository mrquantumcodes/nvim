require 'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = { "php", "html", "css", "javascript" },
	sync_install = false,
	auto_install = true,
	ignore_install = {},
	highlight = {
		enable = true,
		-- disable = {"php"},
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = false
	},
	queries = {
		-- highlights = "../queries/highlights.scm",
	},
}

function callHighlight()
	-- vim.cmd [[
	-- 		hi TSNone guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE
	-- 		hi TSPunctBracket guifg=#ff0000
	-- 		hi TSPunctDelimiter guifg=#00ff00
	-- 		hi TSPunctSpecial guifg=#0000ff
	-- 		hi TSPunctSpecial2 guifg=#ffff00
	-- 	]]

	-- vim.cmd("syntax match TSPunctSpecial /[()]/")
	-- vim.cmd("syntax match TSPunctBracket /[[]]/")
	vim.cmd("syntax match TSPunctDelimiter /[{}]/")
	vim.cmd("syntax match TSPunctSpecial2 /[<>]/")
	vim.cmd("syntax match @php.dollar /[$]/")

	vim.cmd [[
        hi TSNone guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE
        hi TSPunctBracket guifg=#ff0000
        hi TSPunctDelimiter guifg=#00ff00
        hi TSPunctSpecial guifg=#0000ff
        hi TSPunctSpecial2 guifg=#ffff00
        hi TSDollar guifg=#ffff00
    ]]

	vim.cmd("hi @tag.delimiter.html guifg=#9ADE7B")
	vim.cmd("hi @variable.php guifg=#9ADE7B")
	vim.cmd("hi @punctuation.bracket.javascript guifg=red")
	vim.cmd("hi @punctuation.bracket.php guifg=red")
	vim.cmd("hi @php.dollar guifg=blue")

    -- Link your custom highlight groups to existing Treesitter groups
    -- vim.cmd("hi! link TSPunctSpecial TSPunctSpecial2")
    -- vim.cmd("hi! link TSPunctBracket TSPunctDelimiter")
end

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.php",
	callback = function()
		-- Highlight different brackets with distinct colors
		callHighlight()

		-- vim.cmd [[
	end,
})

--     hi TSPunctBracket guifg=#ff0000      " Red for square brackets
--     hi TSPunctDelimiter guifg=#00ff00    " Green for curly brackets
--     hi TSPunctSpecial guifg=#0000ff      " Blue for parentheses
--     hi TSPunctSpecial guifg=#ffff00      " Yellow for angle brackets
-- ]]


vim.keymap.set("n", "<leader>ups", function()
	vim.cmd([[
		:profile start /tmp/nvim-profile.log
		:profile func *
		:profile file *
	]])
end, { desc = "Profile Start" })

vim.keymap.set("n", "<leader>upe", function()
	vim.cmd([[
		:profile stop
		:e /tmp/nvim-profile.log
	]])
end, { desc = "Profile End" })
