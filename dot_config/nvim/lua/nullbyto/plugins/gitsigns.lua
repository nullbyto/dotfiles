return {
    "lewis6991/gitsigns.nvim",
    config = function ()
        require('gitsigns').setup {
            signs = {
                add          = { text = '┃' },
                change       = { text = '┃' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            signs_staged = {
                add          = { text = '┃' },
                change       = { text = '┃' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            signs_staged_enable = true,
            signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
            numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
            linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir = {
                follow_files = true
            },
            auto_attach = true,
            attach_to_untracked = false,
            current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
                virt_text_priority = 100,
                use_focus = true,
            },
            current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil, -- Use default
            max_file_length = 40000, -- Disable if file is longer than this (in lines)
            preview_config = {
                -- Options passed to nvim_open_win
                border = 'single',
                style = 'minimal',
                relative = 'cursor',
                row = 0,
                col = 1
            },
            on_attach = function(bufnr)
                local gitsigns = require('gitsigns')

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({']c', bang = true})
                    else
                        gitsigns.nav_hunk('next')
                    end
                end)

                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({'[c', bang = true})
                    else
                        gitsigns.nav_hunk('prev')
                    end
                end)

                -- Actions
                map('n', '<leader>ghs', gitsigns.stage_hunk, { desc = "Stage current hunk" })
                map('n', '<leader>ghr', gitsigns.reset_hunk, { desc = "Reset current hunk" })

                map('v', '<leader>ghs', function()
                    gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end, { desc = "Stage selected hunk" })

                map('v', '<leader>ghr', function()
                    gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end, { desc = "Reset selected hunk" })

                -- Buffer Operations
                map('n', '<leader>ghS', gitsigns.stage_buffer, { desc = "Stage entire buffer" })
                map('n', '<leader>ghR', gitsigns.reset_buffer, { desc = "Reset entire buffer" })

                -- Preview & Blame
                map('n', '<leader>ghp', gitsigns.preview_hunk, { desc = "Preview current hunk" })
                map('n', '<leader>ghi', gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" })

                map('n', '<leader>ghb', function()
                    gitsigns.blame_line({ full = true })
                end, { desc = "Show full git blame for current line" })

                -- Diff Operations
                map('n', '<leader>ghd', gitsigns.diffthis, { desc = "Diff against index" })

                map('n', '<leader>ghD', function()
                    gitsigns.diffthis('~')
                end, { desc = "Diff against previous commit" })

                -- Quickfix List
                map('n', '<leader>ghQ', function() gitsigns.setqflist('all') end, { desc = "Add all hunks to quickfix list" })
                map('n', '<leader>ghq', gitsigns.setqflist, { desc = "Add file hunks to quickfix list" })

                -- Toggles
                map('n', '<leader>gtb', gitsigns.toggle_current_line_blame, { desc = "Toggle inline git blame" })
                map('n', '<leader>gtd', gitsigns.toggle_deleted, { desc = "Toggle deleted lines" })
                map('n', '<leader>gtw', gitsigns.toggle_word_diff, { desc = "Toggle word diff highlighting" })

                -- Text Object
                map({'o', 'x'}, 'gih', gitsigns.select_hunk, { desc = "Select hunk as text object" })
            end
        }
    end
}

