return {
    'goolord/alpha-nvim',
    enabled = true,
    config = function ()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end
}
