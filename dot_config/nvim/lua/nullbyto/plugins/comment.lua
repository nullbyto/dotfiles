return {
    'numToStr/Comment.nvim',
    opts = {
        -- add any options here
        vim.keymap.set('n', '<leader>/', '<Plug>(comment_toggle_linewise_current)', { desc = "Comment toggle current line(s)" });
        vim.keymap.set('x', '<leader>/', '<Plug>(comment_toggle_linewise_visual)', { desc = "Comment toggle current selection" });
    },
    lazy = false,
}
