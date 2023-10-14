vim.g.mapleader = " "

vim.keymap.set("x", "<leader>p", [["_dP]], {})
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>xx", "<cmd>!chmod +x %<CR>", { silent = true })

-- Clear highlight on esc
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- extra save file
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Move to window using ctrl - {ijkl}
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- open
vim.keymap.set("n", "<leader>o-", vim.cmd.Ex, { desc = "Neovim (Ex)plorer" })
vim.keymap.set("n", "<leader>od", ":Alpha <cr>", { desc = "Dashboard" })
vim.keymap.set("n", "<leader>ol", ":Lazy <cr>", { desc = "Plugin manager" })
vim.keymap.set("n", "<leader>om", ":Mason <cr>", { desc = "Editor toolings manager" })

-- new file
vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- buffers
vim.keymap.set("n", "<leader>,", ":Telescope buffers <cr>", { desc = "Switch buffer" })
vim.keymap.set("n", "<leader>bb", ":Telescope buffers <cr>", { desc = "Switch buffer" })
vim.keymap.set("n", "<leader>bn", ":bnext <cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprev <cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "[b", "<cmd>bprev<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bk", ":bd <cr>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bd", ":bd <cr>", { desc = "Delete buffer" })

-- windows
-- map <leader>w to <c-w> prefix and show whichkey help
--vim.keymap.set("n", "<leader>w", "<c-w>", { remap = true })
vim.keymap.set("n", "<leader>w", "<cmd>WhichKey<c-w><cr>")

-- quit
vim.keymap.set("n", "<leader>qq", ":qa <cr>", { desc = "Quit all" })
