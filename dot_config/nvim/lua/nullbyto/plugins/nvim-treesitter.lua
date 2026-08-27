return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function () 
		local config = require("nvim-treesitter.config")

		config.setup({
			ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "html", "rust"
                , "go", "toml", "bash", "python", "typescript", "ron", "markdown" },
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },  
		})
	end
}
