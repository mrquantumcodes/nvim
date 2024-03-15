-- vim.cmd("colorscheme sorbet")
vim.cmd("colorscheme wildcharm")

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })

vim.api.nvim_set_hl(0, "StatusType", { bg="#b16286", fg="#1d2021" });
vim.api.nvim_set_hl(0, "StatusFile", { bg="#fabd2f", fg="#1d2021" });
vim.api.nvim_set_hl(0, "StatusModified", { bg="#1d2021", fg="#d3869b" });
vim.api.nvim_set_hl(0, "StatusBuffer", { bg="#98971a", fg="#1d2021" });
vim.api.nvim_set_hl(0, "StatusLocation", { bg="#458588", fg="#1d2021" });
vim.api.nvim_set_hl(0, "StatusPercent", { bg="#1d2021", fg="#ebdbb2" });
vim.api.nvim_set_hl(0, "StatusNorm", { bg="none", fg="white" });

vim.api.nvim_set_hl(0, "NormalFloat", { bg="none" });
vim.api.nvim_set_hl(0, "FloatBorder", { bg="none" });

-- vim.cmd("hi NormalFloat guibg=none")
-- vim.cmd("hi FloatBorder guibg=#ccc")
-- vim.cmd "highlight StatusType guibg=#b16286 guifg=#1d2021"
-- vim.cmd "highlight StatusFile guibg=#fabd2f guifg=#1d2021"
-- vim.cmd "highlight StatusModified guibg=#1d2021 guifg=#d3869b"
-- vim.cmd "highlight StatusBuffer guibg=#98971a guifg=#1d2021"
-- vim.cmd "highlight StatusLocation guibg=#458588 guifg=#1d2021"
-- vim.cmd "highlight StatusPercent guibg=#1d2021 guifg=#ebdbb2"
-- vim.cmd "highlight StatusNorm guibg=none guifg=white"

vim.cmd("hi NormalFloat guibg=none")
vim.cmd("hi FloatBorder guibg=#ccc")


-- devicons = require 'nvim-web-devicons'

-- Function to subtract the cwd directory from a given path
function subtract_cwd()
    -- Replace backslashes with forward slashes for platform independence
	fullPath = vim.fn.expand('%:p'):gsub("\\", "/")
	pathToRemove = vim.fn.getcwd():gsub("\\", "/")

	-- Normalize paths by removing trailing slashes
	fullPath = fullPath:gsub("/$", "")
	pathToRemove = pathToRemove:gsub("/$", "")

	local fullPathLen = #fullPath
	local pathToRemoveLen = #pathToRemove

	local i = 1
	while i <= fullPathLen and i <= pathToRemoveLen do
		if fullPath:sub(i, i) == pathToRemove:sub(i, i) then
			i = i + 1
		else
			break
		end
	end

	if i > pathToRemoveLen then
		-- Remove pathToRemove and any leading slash
		return fullPath:sub(i + 1)
	else
		return fullPath
	end
  end  

function statusline()
    -- f_icon = (vim.bo.filetype ~= "" and devicons.get_icon("", vim.bo.filetype) or "-")

    vim.o.statusline = table.concat({
        ""
        ," "
        ,"%l"
        ," "
        ," %#StatusType#"
        ,"<< "
        -- ,.. f_icon .. " %Y"
        -- ,.. " 📃 "
        ," >>"
        ,"%#StatusFile#"
        ,"<< "
        ,subtract_cwd()
        ," >>"
        ,"%#StatusModified#"
        ," "
        ,"%m"
        ," "
        ,"%#StatusNorm#"
        ,"%="
        ,"%#StatusBuffer#"
        ,"<< "
        ,"📟"
        ,"%n"
        ," >>"
        ,"%#StatusLocation#"
        ,"<< "
        ,"📁 "
        ,"%l,%c"
        ," >>"
        ,"%#StatusPercent#"
        ,"<< "
        ,"%p%%  "
        ," >> "
    })
end

statusline()

vim.cmd([[
  augroup BufferChange
    autocmd!
    autocmd BufEnter,BufLeave * lua statusline()
  augroup END
]])
