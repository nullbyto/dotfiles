return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",         -- required
        "nvim-telescope/telescope.nvim", -- optional
        "sindrets/diffview.nvim",        -- optional
        "ibhagwan/fzf-lua",              -- optional
    },
    config = true,
    opts = function ()
        vim.keymap.set("n","<leader>gg" ,":Neogit<cr>")
    end
}
