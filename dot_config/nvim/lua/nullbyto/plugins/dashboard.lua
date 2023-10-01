return {
    'glepnir/dashboard-nvim',
    enabled = false,
    event = 'VimEnter',
    config = function()
        require('dashboard').setup {
            -- config
            theme = "doom",
            config = {
                header = {"hello"}, --your header
                center = {
                    {
                        icon = ' ',
                        icon_hl = 'Title',
                        desc = 'Find File           ',
                        desc_hl = 'String',
                        key = 'b',
                        keymap = 'SPC f f',
                        key_hl = 'Number',
                        action = 'lua print(2)'
                    },
                    {
                        icon = ' ',
                        desc = 'Find Dotfiles',
                        key = 'f',
                        keymap = 'SPC f d',
                        action = 'lua print(3)'
                    },
                },
                footer = {}  --your footer
            },
        }
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
}
