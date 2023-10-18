return {
    'numToStr/Comment.nvim',
    opts = function()
        vim.keymap.set('n', '<leader>/', '<Plug>(comment_toggle_linewise_current)', { desc = "Comment toggle current line(s)" })
        vim.keymap.set('x', '<leader>/', '<Plug>(comment_toggle_linewise_visual)', { desc = "Comment toggle current selection" })
        return {
            -- add any options here
        }
    end,
    lazy = false,
}
