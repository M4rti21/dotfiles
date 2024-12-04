local key = vim.keymap

key.set("n", "<leader>pv", vim.cmd.Ex, { desc = "[P]roject [N]etrw" })
key.set("n", "J", "mzJ`z")
key.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
key.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
key.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
key.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
key.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Quickfix list
key.set("n", "<C-j>", "<cmd>cnext<CR>zz", { desc = "Forward quickfix list" })
key.set("n", "<C-k>", "<cmd>cprev<CR>zz", { desc = "Backward quickfix list" })

-- Location list
key.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Backward location list" })
key.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Forward location list" })

key.set("x", "<leader>p", [["_dP]], { desc = "[p]aste without copying" })
key.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "[d]elete without copying" })

-- Increment
key.set("n", "+", "<C-a>")
key.set("n", "-", "<C-x>")

-- Seelect all
-- key.set("n", "<C-a>", "gg<S-v>G")

-- FUN

-- Disable arrow keys
key.set("n", "<left>", "<cmd>echo 'Use h to move!!'<CR>")
key.set("n", "<right>", "<cmd>echo 'Use l to move!!'<CR>")
key.set("n", "<up>", "<cmd>echo 'Use k to move!!'<CR>")
key.set("n", "<down>", "<cmd>echo 'Use j to move!!'<CR>")

-- Ctrl-C exit insert
key.set("i", "<C-c>", "<Esc>")

key.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
key.set("n", "Q", "<nop>")

key.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Cmod [x] current file" })
key.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
key.set("i", "<D-Space>", "")
