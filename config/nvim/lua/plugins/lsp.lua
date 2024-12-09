return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"artemave/workspace-diagnostics.nvim",
		"saghen/blink.cmp",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}

		-- LSP servers and clients communicate what features they support through "capabilities".
		--  By default, Neovim support a subset of the LSP specification.
		--  With blink.cmp, Neovim has *more* capabilities which are communicated to the LSP servers.
		--  Explanation from TJ: https://youtu.be/m8C0Cq9Uv9o?t=1275
		--
		-- This can vary by config, but in-general for nvim-lspconfig:
		local workspace_diagnostics = require("workspace-diagnostics")
		workspace_diagnostics.setup()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls" },
			automatic_installation = true,
			handlers = {
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
						on_attach = workspace_diagnostics.populate_workspace_diagnostics,
					})
				end,
				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						on_attach = workspace_diagnostics.populate_workspace_diagnostics,
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
								},
							},
						},
					})
				end,
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local builtin = require("telescope.builtin")
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end
				map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
				map("gr", builtin.lsp_references, "[G]oto [R]eferences")
				map("gi", builtin.lsp_implementations, "[G]oto [I]mplementation")
				map("gt", builtin.lsp_type_definitions, "[G]oto [T]ype Definition")
				--map("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
				--map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<A-return>", vim.lsp.buf.code_action, "[C]ode [A]ction")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				map("K", vim.lsp.buf.hover, "Hover Documentation")
			end,
		})

		vim.api.nvim_set_keymap("n", "<space>x", "", {
			noremap = true,
			callback = function()
				for _, client in ipairs(vim.lsp.buf_get_clients()) do
					require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
				end
			end,
		})
	end,
}
