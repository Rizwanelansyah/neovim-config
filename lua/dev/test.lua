local function insp(obj)
	print(vim.inspect(obj))
	return obj
end

local Input = require("nui.input")

local whoayu = Input({
	size = {
		width = 60,
	},
	relative = {
		type = "cursor",
		position = {
			row = 0,
			col = 0,
		},
	},
	border = {
		style = "double",
		padding = { 1, 1, 1, 1 },
	},
	position = {
		col = 0,
		row = 0,
	},
}, {
	prompt = "What's your name? ",
	on_submit = function(value)
		print(("Hello %s!"):format(value or "Guest"))
	end,
})
whoayu:map("n", "q", function()
	whoayu:unmount()
end)

vim.keymap.set("n", "<leader>ti", function()
	whoayu:mount()
end)

local Menu = require("nui.menu")

local lines = {}
-- table.insert(lines, Menu.item("Hello World!"))``

local menu = Menu({
	size = {
		width = 20,
	},
	relative = {
		type = "cursor",
		position = { col = 0, row = 0 },
	},
	border = "none",
	padding = { 3, 1, 3, 1 },
	position = {
		row = 0,
		col = 0,
	},
	winlight = "Normal:MyRedBg",
}, {
	lines = lines,
	keymap = {
		close = "<ESC>",
		focus_next = "<Down>",
		focus_prev = "<Up>",
		submit = "<CR>",
	},
	should_skip_item = function(node)
		return false
	end,
	on_submit = function(item)
		print(vim.inspect(item.text))
		vim.api.nvim_input("a" .. item.text)
	end,
})
vim.keymap.set("n", "<leader>tm", function()
	menu:mount()
end)
vim.keymap.set("i", "<C-S-i>", function()
	vim.cmd([[stopinsert]])
	menu:mount()
end)
