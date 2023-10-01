return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function () 
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "html", "rust", "go", "toml", "bash", "python", "typescript" },
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },  
		})
	end
}
