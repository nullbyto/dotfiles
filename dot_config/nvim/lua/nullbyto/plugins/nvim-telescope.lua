return {
	'nvim-telescope/telescope.nvim', tag = '0.1.3',
	-- or                              , branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local builtin = require('telescope.builtin')
        local utils = require("telescope.utils")
		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Telescope find" })
		vim.keymap.set('n', '<leader>fF', function() builtin.find_files({ cwd = utils.buffer_dir() }) end, { desc = "Telescope find (cwd)" })
		vim.keymap.set('n', '<leader>fa', ":Telescope find_files hidden=true <cr>", { desc = "Telescope find all" })
		vim.keymap.set('n', '<leader>fr', builtin.oldfiles,  { desc = "Telescope recent files" })
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Telescope grep" })
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Telescope buffers" })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Telescope help" })
	end
}
