return {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = function()
        -- restore the session for the current directory
        vim.keymap.set("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], { desc = "Restore session for current dir" });

        -- restore the last session
        vim.keymap.set("n", "<leader>ql", [[<cmd>lua require("persistence").load({ last = true })<cr>]], { desc = "Restore last session" });

        -- stop Persistence => session won't be saved on exit
        vim.keymap.set("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]], { desc = "Stop persistence" });

        return {
            -- add any custom options here
        }
    end,
}
