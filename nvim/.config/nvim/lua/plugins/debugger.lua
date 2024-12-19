local js_langs = {
	"javascript",
	"typescript",
	"javascriptreact",
	"typescriptreact",
	"vue",
}

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		"mxsdev/nvim-dap-vscode-js",
		{
			"microsoft/vscode-js-debug",
			build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
		},
	},
	config = function()
		local dap = require("dap")
		local daputils = require("dap.utils")
		local dapui = require("dapui")
		local dapvirt = require("nvim-dap-virtual-text")
		local dapvscodejs = require("dap-vscode-js")

		dapui.setup()
		dapvirt.setup()

		dapvscodejs.setup({
			debugger_path = os.getenv("HOME") .. "/.local/share/nvim/lazy/vscode-js-debug", -- Path to vscode-js-debug installation.
			adapters = {
				"pwa-node",
				"pwa-chrome",
				"pwa-msedge",
				"node-terminal",
				"pwa-extensionHost",
			},
		})

		for _, lang in ipairs(js_langs) do
			dap.configurations[lang] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Debug file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "launch",
					name = "Debug file (bun)",
					program = "${file}",
					cwd = "${workspaceFolder}",
					runtimeExecutable = "bun",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					processId = daputils.pick_process,
					cwd = "${workspaceFolder}",
				},
			}
		end

		vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "", texthl = "", linehl = "", numhl = "" })

		vim.keymap.set("n", "<leader>do", dapui.toggle, { desc = "[d]ap [o]pen/close" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "[d]ap [c]ontinue" })
		vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "[d]ap run [l]ast" })
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "[b]reakpoint" })
		vim.keymap.set("n", "<leader>gb", dap.run_to_cursor, { desc = "dap [g]o [b]reakpoint (cursor)" })
		vim.keymap.set("n", "<leader>?", function()
			dapui.eval(nil, { enter = true })
		end, { desc = "dap var info" })
		vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "[d]ap [r]estart" })

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
	end,
}
