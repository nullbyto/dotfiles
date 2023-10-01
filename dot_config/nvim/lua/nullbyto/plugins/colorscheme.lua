return {
	{ "catppuccin/nvim" },
	{"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "moon",
			transparent = true,
		},
		--config = function()
		-- 	vim.cmd([[colorscheme catppuccin-macchiato]])
		--	vim.cmd([[colorscheme tokyonight]])
		--end,
	},
}
