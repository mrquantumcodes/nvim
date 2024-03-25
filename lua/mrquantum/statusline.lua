-- vim.cmd("colorscheme sorbet")
vim.cmd("colorscheme sorbet")

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


vim.cmd("hi NormalFloat guibg=none")
vim.cmd("hi FloatBorder guibg=#ccc")


vim.api.nvim_create_autocmd({'BufEnter', 'BufLeave'}, {
	callback = function()
		curr_buffer = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
		if vim.fn.filereadable(curr_buffer) == 1 then
			statusline()
		end
	end
})

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

function table_contains(tbl, x)
	found = false
	for _, v in pairs(tbl) do
		if v == x then 
			found = true 
		end
	end
	return found
end

function array_reverse(x)
	local n, m = #x, #x/2
	for i=1, m do
		x[i], x[n-i+1] = x[n-i+1], x[i]
	end
	return x
end



function transformPath(inputPath)
	-- Replace backslashes with forward slashes
	local cleanedPath = inputPath:gsub(vim.fn.getcwd(), ""):gsub("\\", "/")
	-- local cleanedPath = inputPath:gsub("\\", "/")

	-- Split the path into directory and filename parts
	local parts = {}
	for part in cleanedPath:gmatch("[^/]+") do
		table.insert(parts, part)
	end

	-- Process directory names (except the last one)
	local transformedPath = ""
	for i = 1, #parts - 1 do
		local dirName = parts[i]
		local firstLetter = dirName:sub(1, 1)
		transformedPath = transformedPath .. "/" .. firstLetter
	end

	-- Append the filename
	transformedPath = transformedPath .. "/" .. parts[#parts]

	return transformedPath
end

-- Example usage

-- get buffer list and concatenate it into a string, with the current buffer highlighted
function get_buffer_list()
	local ls_cmd = vim.api.nvim_exec("ls t", true)

	-- extract buffer names from ls command
	bufferList = {}
	curr_buffer = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
	if vim.fn.filereadable(curr_buffer) == 1 then
		table.insert(bufferList, transformPath(subtract_cwd(curr_buffer)))
	end
	-- print(bufferList[1])
	for bufferName in ls_cmd:gmatch("[^\n]+") do
		bufferName = bufferName:match("\"(.-)\"")
		bufferName = bufferName:gsub("\\", "/")

		if bufferName == "" or bufferName == "[No Name]" then
			-- goto continue
		else

			-- print(vim.inspect(bufferList))
			table.insert(bufferList, transformPath(bufferName))

			-- currBufTransformed = transformPath(curr_buffer:gsub(vim.fn.getcwd(), ""))
			-- bufNameTransformed = transformPath(bufferName)


		end

		-- end
	end

	-- if empty buffer list, return
	if #bufferList == 0 then
		return ""
	end

	-- reverse the buffer list so that the most recently opened buffer is first
	-- bufferList = array_reverse(bufferList)


	-- print(vim.inspect(bufferList))

	local bufferString = ""
	local currentBuffer = vim.api.nvim_get_current_buf()

	-- local myBufferList = {}

	for i, buffer in ipairs(bufferList) do
		local bufferName = buffer
		bufferNameShort = transformPath(bufferName)
		-- print(bufferNameShort)

		if bufferNameShort == nil then
			bufferNameShort = bufferName
		end
		local bufferNameShortLen = #bufferNameShort

		if bufferNameShort == "" then
			goto continue
		end

		if i == 1 then
			bufferString = " " .. bufferString .. "%#StatusBuffer# "
		else
			bufferString = " " .. bufferString .. " %#StatusFile# "
			bufferNameShort = bufferNameShort:match("([^/]+)$")
		end

		bufferString = bufferString .. bufferNameShort

		if i < #bufferList then
			bufferString = bufferString .. " "
		end

		-- if buffer string is going out of bounds, break
		if #bufferString > 102 then
			bufferString = bufferString .. " %#StatusNorm# ....."
			break
		end

		-- end

		::continue::

	end

	return bufferString
end

-- get the current buffer number
function get_buffer_number()
	return vim.api.nvim_get_current_buf()
end

-- get the current buffer name
function get_buffer_name()
	return subtract_cwd(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()))
end

-- get the current buffer type
function get_buffer_type()
	return vim.bo.filetype
end

configpulse = require('configpulse').get_time()

function statusline(update_configpulse)

	if update_configpulse then
		configpulse = require('configpulse').get_time()
	end



	-- f_icon = (vim.bo.filetype ~= "" and devicons.get_icon("", vim.bo.filetype) or "-")
	--

	vim.opt.statusline = table.concat({
		""
		," "
		,"%l"
		,"%#StatusModified#"
		," "
		,"%m"
		," Configpulse " .. configpulse.days .. ":" .. configpulse.hours .. ":" .. configpulse.minutes .. ""
		-- Buffer List
		-- ,"%#StatusFile#"
		-- ," "
		,get_buffer_list()
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

vim.keymap.set("n", "<leader>ss", ":lua statusline(true); print('Statusline Updated')<CR>", { noremap = true, silent = true, expr = false })
