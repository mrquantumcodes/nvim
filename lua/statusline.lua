-- local modes = {
--     ["n"] = "NORMAL",
--     ["no"] = "NORMAL",
--     ["v"] = "VISUAL",
--     ["V"] = "VISUAL LINE",
--     [""] = "VISUAL BLOCK",
--     ["s"] = "SELECT",
--     ["S"] = "SELECT LINE",
--     [""] = "SELECT BLOCK",
--     ["i"] = "INSERT",
--     ["ic"] = "INSERT",
--     ["R"] = "REPLACE",
--     ["Rv"] = "VISUAL REPLACE",
--     ["c"] = "COMMAND",
--     ["cv"] = "VIM EX",
--     ["ce"] = "EX",
--     ["r"] = "PROMPT",
--     ["rm"] = "MOAR",
--     ["r?"] = "CONFIRM",
--     ["!"] = "SHELL",
--     ["t"] = "TERMINAL",
-- }

-- local function mode()
--     local current_mode = vim.api.nvim_get_mode().mode
--     return string.format(" %s ", modes[current_mode]):upper()
-- end

-- _G.statusline = function()
--     local set_color_1 = "%#PmenuSel#"
--     local set_color_2 = "%#PmenuSel#"
--     -- local set_color_2 = "%#LineNr#"
--     local current_mode = mode()
--     local file_name = " %f"
--     local modified = "%m"
--     local align_right = "%="
--     local fileencoding = " %{&fileencoding?&fileencoding:&encoding}"
--     local fileformat = " [%{&fileformat}]"
--     local filetype = " %y"
--     local percentage = " %p%%"
--     local linecol = " %l:%c"

--     vim.opt.statusline = string.format(
--         "%s %s %s%s%s%s%s%s%s%s%s",
--         set_color_1,
--         current_mode,
--         set_color_2,
--         file_name,
--         modified,
--         align_right,
--         filetype,
--         fileencoding,
--         fileformat,
--         percentage,
--         linecol
--     )
-- end

-- -- Delay setting the statusline by 1 second

-- statusline()





vim.cmd "highlight StatusType guibg=#b16286 guifg=#1d2021"
vim.cmd "highlight StatusFile guibg=#fabd2f guifg=#1d2021"
vim.cmd "highlight StatusModified guibg=#1d2021 guifg=#d3869b"
vim.cmd "highlight StatusBuffer guibg=#98971a guifg=#1d2021"
vim.cmd "highlight StatusLocation guibg=#458588 guifg=#1d2021"
vim.cmd "highlight StatusPercent guibg=#1d2021 guifg=#ebdbb2"
vim.cmd "highlight StatusNorm guibg=none guifg=white"
vim.o.statusline = " "
    .. ""
    .. " "
    .. "%l"
    .. " "
    .. " %#StatusType#"
    .. "<< "
    .. "%Y"
    .. " 📃 "
    .. " >>"
    .. "%#StatusFile#"
    .. "<< "
    .. "%F"
    .. " >>"
    .. "%#StatusModified#"
    .. " "
    .. "%m"
    .. " "
    .. "%#StatusNorm#"
    .. "%="
    .. "%#StatusBuffer#"
    .. "<< "
    .. "📟"
    .. "%n"
    .. " >>"
    .. "%#StatusLocation#"
    .. "<< "
    .. "📁 "
    .. "%l,%c"
    .. " >>"
    .. "%#StatusPercent#"
    .. "<< "
    .. "%p%%  "
    .. " >> "
