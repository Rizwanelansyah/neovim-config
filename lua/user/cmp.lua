local lspkind = require("lspkind")
local cmp = require("cmp")

vim.api.nvim_set_hl(0, "MyCmpSource", { bg = "#BBBBBB", fg = "#000000" })
vim.api.nvim_set_hl(0, "MyPurpleBg", { bg = "#401d7d", fg = "#000000" })
vim.api.nvim_set_hl(0, "MyBlueBg", { bg = "#0052e0", fg = "#000000" })
vim.api.nvim_set_hl(0, "MyRedBg", { bg = "#d12828", fg = "#000000" })
vim.api.nvim_set_hl(0, "MyOrangeBg", { bg = "#d97809", fg = "#000000" })

local kinds_hl = {
	Text = "MyCmpSource",
	Method = "MyPurpleBg",
	Function = "MyPurpleBg",
	Constructor = "MyOrangeBg",
	Field = "MyBlueBg",
	Variable = "MyRedBg",
	Class = "MyOrangeBg",
	Interface = "MyBlueBg",
	Module = "MyBlueBg",
	Property = "MyBlueBg",
	Unit = "MyPurpleBg",
	Value = "MyRedBg",
	Enum = "MyRedBg",
	Keyword = "MyPurpleBg",
	Snippet = "MyCmpSource",
	Color = "MyRedBg",
	File = "MyBlueBg",
	Reference = "MyBlueBg",
	Folder = "MyOrangeBg",
	EnumMember = "MyBlueBg",
	Constant = "MyOrangeBg",
	Struct = "MyOrangeBg",
	Event = "MyRedBg",
	Operator = "MyRedBg",
	TypeParameter = "MyBlueBg",
}

cmp.setup({
	formatting = {
		fields = { "kind", "abbr", "menu" },
		expandable_indicator = true,
		format = function(entry, vim_item)
			local kind = vim_item.kind
			vim_item.kind = " " .. lspkind.presets.codicons[kind] .. "  "
			vim_item.kind_hl_group = kinds_hl[kind]

			vim_item.menu = ({
				buffer = "BFR",
				nvim_lsp = "LSP",
				luasnip = "SNP",
				nvim_lua = "LUA",
				latex_symbols = "LTX",
			})[entry.source.name]
			if vim_item.menu then
				vim_item.menu = " " .. vim_item.menu .. " "
			end

			vim_item.menu_hl_group = "MyCmpSource"

			return vim_item
		end,
	},
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
		completion = {
			side_padding = 0,
			scrollbar = false,
		},
		documentation = {
			max_height = 20,
		},
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = function()
			if cmp.visible() then
				cmp.close()
			else
				cmp.complete()
			end
		end,
		["<C-c>"] = function()
			if cmp.visible_docs() then
				cmp.close_docs()
			else
				cmp.open_docs()
			end
		end,
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		-- { name = 'vsnip' }, -- For vsnip users.
		{ name = "luasnip" }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = "buffer" },
	}),
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
	}, {
		{ name = "buffer" },
	}),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
