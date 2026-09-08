-- ==========================================
-- Core configuration
-- ==========================================
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 1,
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
        col = {
            active_border = "rgba(33ccffee)",
            inactive_border = "rgba(595959aa)",
        },
    },
    decoration = {
        rounding = 12, -- 1
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
    -- Animations must simply be enabled here. Customizations happen below.
    animations = {
        enabled = true,
    },
    dwindle = {
        preserve_split = true,
        force_split = 2,
    },
    master = {
        new_status = "master",
        new_on_top = true,
    },
    scrolling = {
        fullscreen_on_one_column = true,
    },
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = true,
        on_focus_under_fullscreen = 1, -- cycle maximized/fullscreen windows
        disable_autoreload = false,
    },
    xwayland = { force_zero_scaling = true },
    opengl = { nvidia_anti_flicker = true },

    input = {
        kb_layout = "eu",
        kb_options = "grp:alt_space_toggle",
        follow_mouse = 1,
        sensitivity = 0,
        accel_profile = "adaptive",
        touchpad = { natural_scroll = true },
    },
    cursor = { no_hardware_cursors = 2 },
    binds = {
        drag_threshold = 10 -- Fire a drag event only after dragging for more than 10px
    }
})

