return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"artemave/workspace-diagnostics.nvim",
			{
				"saghen/blink.cmp",
				lazy = false,
				-- dependencies = "rafamadriz/friendly-snippets",
				version = "v0.*",
				opts = {
					keymap = {
						["<Tab>"] = { "accept", "fallback" },
						["<C-j>"] = { "select_next", "fallback" },
						["<C-k>"] = { "select_prev", "fallback" },
						["<C-b>"] = { "scroll_documentation_down", "fallback" },
						["<C-f>"] = { "scroll_documentation_up", "fallback" },
						["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
					},
					sources = {
						default = { "lsp", "path", "snippets" },
					},
					appearance = {
						use_nvim_cmp_as_default = true,
						nerd_font_variant = "mono",
					},
					completion = {
						trigger = {
							prefetch_on_insert = true,
							show_in_snippet = false,
							show_on_keyword = true,
							show_on_trigger_character = false,
							show_on_accept_on_trigger_character = false,
							show_on_insert_on_trigger_character = false,
							show_on_x_blocked_trigger_characters = { "'", '"', "(", "{" },
						},
						documentation = {
							auto_show = false,
							auto_show_delay_ms = 50,
							update_delay_ms = 50,
						},
						ghost_text = {
							enabled = false,
						},
					},
				},
			},
			"pmizio/typescript-tools.nvim",
		},
		config = function()
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local lspconfig = require("lspconfig")
			local lspconfig_defaults = lspconfig.util.default_config
			local workspace_diagnostics = require("workspace-diagnostics")
			workspace_diagnostics.setup({})

			lspconfig_defaults.capabilities = vim.tbl_deep_extend(
				"force",
				lspconfig_defaults.capabilities,
				require("blink.cmp").get_lsp_capabilities()
			)
			lspconfig_defaults.on_attach = workspace_diagnostics.populate_workspace_diagnostics

			mason.setup({})
			mason_lspconfig.setup({
				ensure_installed = { "lua_ls" },
				automatic_installation = false,
				handlers = {
					function(server_name)
						lspconfig[server_name].setup({})
					end,
					["lua_ls"] = function()
						lspconfig.lua_ls.setup({
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
				group = vim.api.nvim_create_augroup("vim-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					map("gd", vim.lsp.buf.definition, "[g]oto [d]efinition")
					map("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
					map("gr", vim.lsp.buf.references, "[g]oto [r]eferences")
					map("gi", vim.lsp.buf.implementation, "[g]oto [i]mplementation")
					map("gt", vim.lsp.buf.type_definition, "[g]oto [t]ype Definition")
					map("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ctions")
					map("K", vim.lsp.buf.hover, "Hover Documentation")
				end,
			})
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
		config = function()
			require("typescript-tools").setup({
				settings = {
					tsserver_locale = "en",
					include_completions_with_insert_text = true,
					code_lens = "off",
				},
			})
		end,
	},
}
