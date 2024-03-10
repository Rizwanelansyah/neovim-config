LOG = function(v)
	print(vim.inspect(v))
	return v
end

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.termguicolors = true

vim.cmd("colorscheme slate")
vim.cmd([[autocmd BufEnter * set formatoptions-=cro]])

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = require("user.plugins")
require("lazy").setup(plugins)

require("user.cmp")
require("user.lspconfig")
require("user.autocmd")
require("user.lualine")
require("user.bufferline")
require("user.keymaps")
