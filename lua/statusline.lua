local modes = {
    ["n"] = "NORMAL",
    ["no"] = "NORMAL",
    ["v"] = "VISUAL",
    ["V"] = "VISUAL LINE",
    [""] = "VISUAL BLOCK",
    ["s"] = "SELECT",
    ["S"] = "SELECT LINE",
    [""] = "SELECT BLOCK",
    ["i"] = "INSERT",
    ["ic"] = "INSERT",
    ["R"] = "REPLACE",
    ["Rv"] = "VISUAL REPLACE",
    ["c"] = "COMMAND",
    ["cv"] = "VIM EX",
    ["ce"] = "EX",
    ["r"] = "PROMPT",
    ["rm"] = "MOAR",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
}

local function mode()
    local current_mode = vim.api.nvim_get_mode().mode
    return string.format(" %s ", modes[current_mode]):upper()
end

_G.statusline = function()
    local set_color_1 = "%#PmenuSel#"
    local set_color_2 = "%#PmenuSel#"
    -- local set_color_2 = "%#LineNr#"
    local current_mode = mode()
    local file_name = " %f"
    local modified = "%m"
    local align_right = "%="
    local fileencoding = " %{&fileencoding?&fileencoding:&encoding}"
    local fileformat = " [%{&fileformat}]"
    local filetype = " %y"
    local percentage = " %p%%"
    local linecol = " %l:%c"

    vim.opt.statusline = string.format(
        "%s %s %s%s%s%s%s%s%s%s%s",
        set_color_1,
        current_mode,
        set_color_2,
        file_name,
        modified,
        align_right,
        filetype,
        fileencoding,
        fileformat,
        percentage,
        linecol
    )
end

-- Delay setting the statusline by 1 second

statusline()