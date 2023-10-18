return {
	'nvim-telescope/telescope.nvim', tag = '0.1.3',
	-- or                              , branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local builtin = require('telescope.builtin')
        local utils = require("telescope.utils")

        -- helper function to fall back to find_files if not .git dir
        local find_files = function(opts)
            if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
                opts.show_untracked = true
                builtin.git_files(opts)
            else
                builtin.find_files(opts)
            end
        end

        -- vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Grep (root dir)" })
        vim.keymap.set("n", "<leader>:", "<cmd>Telescope command_history<cr>", { desc = "Command History" })
		vim.keymap.set('n', '<leader>.', function() find_files({}) end, { desc = "Find file" })
		vim.keymap.set('n', '<leader> ', function() find_files({ cwd = utils.buffer_dir() }) end, { desc = "Find file in project" })
        -- find
		-- vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Telescope find" })
		vim.keymap.set('n', '<leader>ff', function() find_files({}) end, { desc = "Telescope find" })
		vim.keymap.set('n', '<leader>fF', function() find_files({ cwd = utils.buffer_dir() }) end, { desc = "Telescope find (cwd)" })
		vim.keymap.set('n', '<leader>fa', ":Telescope find_files hidden=true <cr>", { desc = "Telescope find all" })
		vim.keymap.set('n', '<leader>fr', builtin.oldfiles,  { desc = "Telescope recent files" })
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Telescope grep" })
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Telescope buffers" })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Telescope help" })
        -- git
        vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "commits" })
        vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "status" })
        -- search
        vim.keymap.set("n", '<leader>s"', "<cmd>Telescope registers<cr>", { desc = "Registers" })
        vim.keymap.set("n", "<leader>sa", "<cmd>Telescope autocommands<cr>", { desc = "Auto Commands" })
        vim.keymap.set("n", "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Buffer" })
        vim.keymap.set("n", "<leader>sc", "<cmd>Telescope command_history<cr>", { desc = "Command History" })
        vim.keymap.set("n", "<leader>s:", "<cmd>Telescope command_history<cr>", { desc = "Command History" })
        vim.keymap.set("n", "<leader>sC", "<cmd>Telescope commands<cr>", { desc = "Commands" })
        vim.keymap.set("n", "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "Document diagnostics" })
        vim.keymap.set("n", "<leader>sD", "<cmd>Telescope diagnostics<cr>", { desc = "Workspace diagnostics" })
        vim.keymap.set("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "Help Pages" })
        vim.keymap.set("n", "<leader>sH", "<cmd>Telescope highlights<cr>", { desc = "Search Highlight Groups" })
        vim.keymap.set("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Key Maps" })
        vim.keymap.set("n", "<leader>sM", "<cmd>Telescope man_pages<cr>", { desc = "Man Pages" })
        vim.keymap.set("n", "<leader>s'", "<cmd>Telescope marks<cr>", { desc = "Jump to Mark" })
        vim.keymap.set("n", "<leader>so", "<cmd>Telescope vim_options<cr>", { desc = "Options" })
        vim.keymap.set("n", "<leader>sR", "<cmd>Telescope resume<cr>", { desc = "Resume" })

	end
}
