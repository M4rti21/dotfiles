return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        -- "folke/lazydev.nvim"
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        vim.keymap.set("n", "<leader>dc", function() dap.continue() end, { desc = "[d]ap [c]ontinue" })
        vim.keymap.set("n", "<leader>do", function() dap.step_over() end, { desc = "[d]ap step [o]ver" })
        vim.keymap.set("n", "<leader>di", function() dap.step_into() end, { desc = "[d]ap step [i]nto" })
        vim.keymap.set("n", "<leader>de", function() dap.step_out() end, { desc = "[d]ap setp out ([e]xit)" })
        vim.keymap.set("n", "<Leader>db", function() dap.toggle_breakpoint() end, { desc = "[d]ap toggle [b]reakpoint" })
        vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
            require("dap.ui.widgets").hover()
        end, { desc = "[d]ap [h]over" })
        vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
            require("dap.ui.widgets").preview()
        end, { desc = "[d]ap [p]review" })
        -- require("neodev").setup({
        --     library = { plugins = { "nvim-dap-ui" }, types = true },
        -- })
        dap.listeners.before.attach.dapui_config = dapui.open
        dap.listeners.before.launch.dapui_config = dapui.open
        dap.listeners.before.event_terminated.dapui_config = dapui.close
        dap.listeners.before.event_exited.dapui_config = dapui.close

        -- ADAPTERS
        -- dap.adapters["pwa-node"] = {
        --     type = "server",
        --     host = "localhost",
        --     port = "${port}",
        --     executable = {
        --         command = "node",
        --         -- 💀 Make sure to update this path to point to your installation
        --         args = { "/path/to/js-debug/src/dapDebugServer.js", "${port}" },
        --     }
        -- }
    end
}
