local wezterm = require("wezterm")

local config = {
    enable_wayland = false,
    audible_bell = "Disabled",
    check_for_updates = false,
    -- color_scheme = "Builtin Solarized Dark",
    color_scheme = "tokyonight_night",
    inactive_pane_hsb = {
        hue = 1.0,
        saturation = 1.0,
        brightness = 1.0,
    },
    -- default_prog = { '/bin/zsh', '-l' },
    font_size = 12.0,
    launch_menu = {},
    enable_scroll_bar = true,
    leader = { key="a", mods="CTRL" },
    disable_default_key_bindings = true,
    window_background_opacity = 0.9,
    keys = {
        -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
        { key = "a", mods = "LEADER|CTRL",  action=wezterm.action{SendString="\x01"}},
        { key = ";", mods = "LEADER",       action="ActivateCommandPalette"},
        { key = "'", mods = "LEADER",       action="ShowLauncher"},
        { key = "-", mods = "LEADER",       action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
        { key = "|", mods = "LEADER|SHIFT", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
        { key = "z", mods = "LEADER",       action="TogglePaneZoomState" },
        { key = "/", mods = "LEADER",       action="ActivateCopyMode" },
        { key = "c", mods = "LEADER",       action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
        { key = "h", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Left"}},
        { key = "j", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Down"}},
        { key = "k", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Up"}},
        { key = "l", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Right"}},
        { key = "H", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Left", 5}}},
        { key = "J", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Down", 5}}},
        { key = "K", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Up", 5}}},
        { key = "L", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Right", 5}}},
        { key = "1", mods = "LEADER",       action=wezterm.action{ActivateTab=0}},
        { key = "2", mods = "LEADER",       action=wezterm.action{ActivateTab=1}},
        { key = "3", mods = "LEADER",       action=wezterm.action{ActivateTab=2}},
        { key = "4", mods = "LEADER",       action=wezterm.action{ActivateTab=3}},
        { key = "5", mods = "LEADER",       action=wezterm.action{ActivateTab=4}},
        { key = "6", mods = "LEADER",       action=wezterm.action{ActivateTab=5}},
        { key = "7", mods = "LEADER",       action=wezterm.action{ActivateTab=6}},
        { key = "8", mods = "LEADER",       action=wezterm.action{ActivateTab=7}},
        { key = "9", mods = "LEADER",       action=wezterm.action{ActivateTab=8}},
        { key = "p", mods = "LEADER",       action=wezterm.action{ActivateTabRelative=-1}},
        { key = "n", mods = "LEADER",       action=wezterm.action{ActivateTabRelative=1}},
        { key = "&", mods = "LEADER|SHIFT", action=wezterm.action{CloseCurrentTab={confirm=true}}},
        { key = "x", mods = "LEADER",       action=wezterm.action{CloseCurrentPane={confirm=true}}},

        { key = "+", mods="CTRL",           action="IncreaseFontSize" },
        { key = "-", mods="CTRL",           action="DecreaseFontSize" },
        { key = "0", mods="CTRL",           action="ResetFontSize" },
        { key = "n", mods="SHIFT|CTRL",     action="ToggleFullScreen" },
        { key = "v", mods="SHIFT|CTRL",     action=wezterm.action.PasteFrom 'Clipboard'},
        { key = "c", mods="SHIFT|CTRL",     action=wezterm.action.CopyTo 'Clipboard'},
    },
    set_environment_variables = {},
    -- tab_bar_at_bottom = true,
    use_fancy_tab_bar = false,
    colors = {
        tab_bar = {
            -- The color of the strip that goes along the top of the window
            -- (does not apply when fancy tab bar is in use)
            background = '#0b0022',

            -- The active tab is the one that has focus in the window
            active_tab = {
                -- The color of the background area for the tab
                bg_color = '#2b2042',
                -- The color of the text for the tab
                fg_color = '#c0c0c0',

                -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
                -- label shown for this tab.
                -- The default is "Normal"
                intensity = 'Normal',

                -- Specify whether you want "None", "Single" or "Double" underline for
                -- label shown for this tab.
                -- The default is "None"
                underline = 'None',

                -- Specify whether you want the text to be italic (true) or not (false)
                -- for this tab.  The default is false.
                italic = false,

                -- Specify whether you want the text to be rendered with strikethrough (true)
                -- or not for this tab.  The default is false.
                strikethrough = false,
            },

            -- Inactive tabs are the tabs that do not have focus
            inactive_tab = {
                bg_color = '#1b1032',
                fg_color = '#808080',

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `inactive_tab`.
            },

            -- You can configure some alternate styling when the mouse pointer
            -- moves over inactive tabs
            inactive_tab_hover = {
                bg_color = '#3b3052',
                fg_color = '#909090',
                italic = true,

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `inactive_tab_hover`.
            },

            -- The new tab button that let you create new tabs
            new_tab = {
                bg_color = '#1b1032',
                fg_color = '#808080',

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `new_tab`.
            },

            -- You can configure some alternate styling when the mouse pointer
            -- moves over the new tab button
            new_tab_hover = {
                bg_color = '#3b3052',
                fg_color = '#909090',
                italic = true,

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `new_tab_hover`.
            },
        },
    }
}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    config.front_end = "Software" -- OpenGL doesn't work quite well with RDP.
    -- This makes the term go crazy on WSL
    -- config.term = "" -- Set to empty so FZF works on windows
    config.default_prog = { "powershell.exe" }
    table.insert(config.launch_menu, { label = "PowerShell", args = {"powershell.exe", "-NoLogo"} })
    table.insert(config.launch_menu, { label = "WSL", args = {"wsl.exe"} })

    -- Find installed visual studio version(s) and add their compilation
    -- environment command prompts to the menu
    for _, vsvers in ipairs(wezterm.glob("Microsoft Visual Studio/20*", "C:/Program Files (x86)")) do
        local year = vsvers:gsub("Microsoft Visual Studio/", "")
        table.insert(config.launch_menu, {
            label = "x64 Native Tools VS " .. year,
            args = {"cmd.exe", "/k", "C:/Program Files (x86)/" .. vsvers .. "/BuildTools/VC/Auxiliary/Build/vcvars64.bat"},
        })
    end
else
    table.insert(config.launch_menu, { label = "bash", args = {"bash", "-l"} })
end

return config
