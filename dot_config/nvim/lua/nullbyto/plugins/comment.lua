return {
    'numToStr/Comment.nvim',
    opts = function()
        vim.keymap.set('n', '<leader>/', '<Plug>(comment_toggle_linewise_current)', { desc = "Comment toggle current line(s)" })
        vim.keymap.set('x', '<leader>/', '<Plug>(comment_toggle_linewise_visual)', { desc = "Comment toggle current selection" })
        return {
            -- add any options here
            -- toggler = {
            --     ---Line-comment toggle keymap
            --     line = '<Nop>',
            --     ---Block-comment toggle keymap
            --     block = '<Nop>',
            -- },
            -- opleader = {
            --     ---Line-comment keymap
            --     line = '<Nop>',
            --     ---Block-comment keymap
            --     block = '<Nop>',
            -- },
            -- ---Enable keybindings
            -- ---NOTE: If given `false` then the plugin won't create any mappings
            -- mappings = {
            --     ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
            --     basic = true,
            --     ---Extra mapping; `gco`, `gcO`, `gcA`
            --     extra = true,
            -- },
        }
    end,
    lazy = false,
}
