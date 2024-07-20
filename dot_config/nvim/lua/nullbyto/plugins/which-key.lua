return {
    {
        "folke/which-key.nvim",
        lazy = true,
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 200
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            plugins = { spelling = true },
            defaults = {
                mode = { "n", "v" },
                { "<leader><tab>", group = "tabs" },
                { "<leader>b", group = "buffer" },
                { "<leader>c", group = "code" },
                { "<leader>f", group = "file/find" },
                { "<leader>g", group = "git" },
                { "<leader>gh", group = "hunks" },
                { "<leader>o", group = "open" },
                { "<leader>q", group = "quit/session" },
                { "<leader>s", group = "search" },
                { "<leader>u", group = "ui" },
                { "<leader>w", group = "windows" },
                { "<leader>x", group = "diagnostics/quickfix" },
                { "[", group = "prev" },
                { "]", group = "next" },
                { "g", group = "goto" },
                { "gz", group = "surround" },
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            -- wk.register(opts.defaults)
            wk.add(opts.defaults)
        end,
    }

}
