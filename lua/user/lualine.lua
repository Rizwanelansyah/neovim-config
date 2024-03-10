require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = {
			{
				"mode",
				fmt = function(mode)
					local kinds = {
						normal = "   NORMAL ",
						insert = "   INSERT ",
						visual = "   VISUAL ",
						["v-block"] = " 󰩭  V-BLOCK",
						vblock = " 󰩭  V-BLOCK",
						command = "   COMMAND",
						select = " 󰫙  SELECT",
					}
					return kinds[mode:lower()] or mode
				end,
			},
		},
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "require'lsp-status'.status()", "progress" },
		lualine_z = { {
			"filename",
			fmt = function(name)
				LOG(name)
				return name
			end,
		} },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
