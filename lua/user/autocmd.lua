vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*.lua" },
	callback = function()
		vim.cmd("silent !stylua %")
	end,
})
