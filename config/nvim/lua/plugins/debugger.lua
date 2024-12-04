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
		{
			"microsoft/vscode-js-debug",
			build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
		},
		{
			"mxsdev/nvim-dap-vscode-js",
			opts = {
				debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
				adapters = { "pwa-node", "pwa-chrome" },
			},
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local dapvirt = require("nvim-dap-virtual-text")

		dapui.setup()
		dapvirt.setup()

		dap.adapters["pwa-node"] = {
			type = "executable",
			host = "127.0.0.1",
			port = "${port}",
			executable = {
				command = "node",
				-- 💀 Make sure to update this path to point to your installation
				args = { "~/.local/bin/js-debug/src/dapDebugServer.js", "${port}" },
			},
		}

		for _, lang in ipairs(js_langs) do
			dap.configurations[lang] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Run file (bun)",
					cwd = "${workspaceFolder}",
					runtimeArgs = { "--inspect-brk" },
					program = "${file}",
					runtimeExecutable = "bun",
					attachSimplePort = 6499,
				},
				{
					type = "pwa-node",
					request = "launch",
					name = "Run file (node)",
					cwd = "${workspaceFolder}",
					sourceMaps = true,
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
					sourceMaps = true,
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
