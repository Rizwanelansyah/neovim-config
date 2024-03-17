local lsp = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = { "lua_ls", "tsserver", "pyright" }
for _, server in ipairs(servers) do
	lsp[server].setup({
		capabilities = capabilities,
	})
end
