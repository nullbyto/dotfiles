vim.g.mapleader = " "

vim.keymap.set("x", "<leader>p", [["_dP]], {})
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>xx", "<cmd>!chmod +x %<CR>", { silent = true })

-- open
vim.keymap.set("n", "<leader>o-", vim.cmd.Ex, { desc = "Neovim (Ex)plorer" })
vim.keymap.set("n", "<leader>on", ":Neotree toggle <cr>", { desc = "Toggle Neotree" })
vim.keymap.set("n", "<leader>ol", ":Lazy <cr>", { desc = "Plugin manager" })
vim.keymap.set("n", "<leader>om", ":Mason <cr>", { desc = "Editor toolings manager" })

-- buffers
vim.keymap.set("n", "<leader>,", ":Telescope buffers <cr>", { desc = "Switch buffer"})
vim.keymap.set("n", "<leader>bb", ":Telescope buffers <cr>", { desc = "Switch buffer"})
vim.keymap.set("n", "<leader>bn", ":bnext <cr>", { desc = "Next buffer"})
vim.keymap.set("n", "<leader>bp", ":bprev <cr>", { desc = "Previous buffer"})
vim.keymap.set("n", "<leader>bk", ":bd <cr>", { desc = "Delete buffer"})
vim.keymap.set("n", "<leader>bd", ":bd <cr>", { desc = "Delete buffer"})

-- quit
vim.keymap.set("n", "<leader>qq", ":q <cr>")
