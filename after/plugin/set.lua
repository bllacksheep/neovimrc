vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.colorcolumn = "80"
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.opt.clipboard = "unnamedplus"
vim.keymap.set("n", "<leader>x", ":luafile %<CR>")
vim.keymap.set("n", "<C-;>", ":w<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>x", ":lua<CR>")

vim.g.python3_host_prog = "~/.pyenv/versions/nvim/bin/python3"
-- vim.keymap.set("n", "<leader>dr", function()
-- 	local cursor = vim.api.nvim_win_get_cursor(0)
-- 	local current_pos = cursor[1]
-- 	local relative_direction = vim.fn.getcharstr()
-- 	local relative_line_no_1 = vim.fn.getcharstr()
-- 	-- could use esc ?
-- 	local relative_line_no_2 = vim.fn.getcharstr()
--
-- 	local jump = tonumber(relative_line_no_1 .. relative_line_no_2) or 0
-- 	local relative_pos
--
-- 	if relative_direction == "u" then
-- 		relative_pos = current_pos - jump
-- 	elseif relative_direction == "d" then
-- 		relative_pos = current_pos + jump
-- 	end
--
-- 	vim.api.nvim_win_set_cursor(0, cursor)
--
-- 	print(current_pos, relative_direction, relative_line_no_1, relative_line_no_2, jump, relative_pos)
-- end)

local job_id = 0
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("term-open", { clear = true }),
	callback = function()
		vim.opt.number = false
		-- vim.opt.relativenumber = false
	end,
})

vim.keymap.set("n", "<leader>st", function()
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 5) -- 5 lines
	vim.bo.modifiable = true
	job_id = vim.bo.channel
end)

vim.keymap.set("n", "<leader>gt", function()
	vim.fn.chansend(job_id, { "echo 'hi'\r\n" })
end)
