return {
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
    event = "VeryLazy",
    opts = function()
      return {
        --[[add your custom lualine config here]]
        options = {
            theme = "tokyonight",
            -- default: powerline arrows seperators
            section_separators = '',
            component_separators = '',
            -- section_separators = { left = '', right = '' },
            -- component_separators = { left = '', right = '' },
        }
      }
    end,
}
