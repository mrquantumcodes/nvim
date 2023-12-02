vim.opt.list = true
vim.opt.listchars = { leadmultispace = "│   ", multispace = "│ ", tab = "│ ", }

-- function AdjustListchars()
-- 	local lead = "|"
-- 	for _ = 1, vim.bo.shiftwidth - 1 do
-- 		lead = lead .. " "
-- 	end
-- 	vim.opt_local.listchars:append({ leadmultispace = lead })
-- end

-- vim.opt_local.shiftwidth = 4
-- AdjustListchars()