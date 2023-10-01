return {
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
    event = "VeryLazy",
    opts = function()
      return {
        --[[add your custom lualine config here]]
        options = {
            theme = "tokyonight",
        }
      }
    end,
}
