-- ==========================================
-- Helper functions
-- ==========================================
local function layout_bind(bind_table)
    return function ()
        local workspace = hl.get_active_special_workspace() or
                          hl.get_active_workspace()

        if not workspace then
            return
        end

        local layout = workspace.tiled_layout

        if bind_table[layout] then
            hl.dispatch(bind_table[layout])
        end
    end
end

local function set_workspace_layout(layout_name)
  return function()
    local ws = hl.get_active_workspace()
    if ws then
      hl.workspace_rule({ workspace = ws.name, layout = layout_name })
    end
  end
end

-- ==========================================
-- Keybindings
-- ==========================================
-- Core apps
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal), { description = "Open terminal" })
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.close(), { description = "Close active window" })
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exit(), { description = "Exit Hyprland" })
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"), { description = "Reload Hyprland configuration" })
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd(lock), { description = "Lock screen" })

hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager), { description = "Open file manager" })
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(browser), { description = "Open browser" })
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu), { description = "Open menu" })
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(launcher), { description = "Open launcher" })

-- Screenshots
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region -z -o ~/Pictures/Screenshots --clipboard-only"))
-- hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m output -m active -z -o ~/Pictures/Screenshots"))
-- hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m region -z -o ~/Pictures/Screenshots"))
-- hl.bind("CTRL + Print", hl.dsp.exec_cmd("hyprshot -m output -m active --raw | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("noctalia msg screenshot-region"), { description = "Screenshot region" })
hl.bind("Print", hl.dsp.exec_cmd("noctalia msg screenshot-fullscreen"), { description = "Screenshot fullscreen" })
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("noctalia msg screenshot-fullscreen all"), { description = "Screenshot all screens" })
hl.bind("CTRL + Print", hl.dsp.exec_cmd("noctalia msg screenshot-fullscreen pick"), { description = "Screenshot pick screen" })

-- Waybar
-- hl.bind(mainMod .. " + CTRL + R", hl.dsp.exec_cmd("killall waybar; hyprctl dispatch exec waybar"))
-- hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))
-- hl.bind(mainMod .. " + delete", hl.dsp.exec_cmd("wlogout -b 6 -T 400 -B 400"))

-- Utility
hl.bind(mainMod .. " + CTRL + R", hl.dsp.exec_cmd("killall noctalia; noctalia -d"), { description = "Restart noctalia" })
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("noctalia msg bar-toggle"), { description = "Toggle bar" })
hl.bind(mainMod .. " + delete", hl.dsp.exec_cmd("noctalia msg panel-toggle session"), { description = "Toggle power panel" })
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center notifications"), { description = "Toggle notifications" })
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("noctalia msg notification-dnd-toggle"), { description = "Toggle Do Not Disturb" })
hl.bind(mainMod .. " + CTRL + N", hl.dsp.exec_cmd("noctalia msg nightlight-force-toggle"), { description = "Toggle Night Light" })
-- hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
-- hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client -d -sw"))

-- Window layouts & States
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle window float" })
-- hl.bind(mainMod .. " + ALT + V", hl.dsp.exec_cmd("hyprctl dispatch workspaceopt allfloat"), { description = "Toggle all windows float" })
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo(), { description = "Toggle pseudo tiling" })
hl.bind(mainMod .. " + semicolon", hl.dsp.layout("togglesplit"), { description = "Toggle split direction" })    -- dwindle only
hl.bind(mainMod .. " + S", set_workspace_layout("dwindle"), { description = "Set active workspace layout to dwindle" })
hl.bind(mainMod .. " + T", set_workspace_layout("master"), { description = "Set active workspace layout to master" })
hl.bind(mainMod .. " + M", set_workspace_layout("monocle"), { description = "Set active workspace layout to monocle" })
hl.bind(mainMod .. " + Y", set_workspace_layout("scrolling"), { description = "Set active workspace layout to monocle" })

-- hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = "maximized"}), { description = "Toggle maximize" })
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.window.fullscreen({ mode = "maximized"}), { description = "Toggle maximize" })
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized"}), { description = "Toggle maximize" })
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen(), { description = "Toggle fullscreen" })
hl.bind(mainMod .. " + CTRL + F", hl.dsp.window.fullscreen_state({ internal = 2, client = -1 }), { description = "Fake fullscreen" })
hl.bind(mainMod .. " + CTRL + SHIFT + F", hl.dsp.window.fullscreen_state({ internal = -1, client = 2 }), { description = "Fake fullscreen (client only)" })

-- Special Workspaces
hl.bind(mainMod .. " + Z", hl.dsp.workspace.toggle_special("magic"), { description = "Toggle special workspace (magic)" })
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.window.move({ workspace = "special:magic" }), { description = "Move window to special workspace (magic)" })
hl.bind(mainMod .. " + slash", hl.dsp.workspace.toggle_special("magic"), { description = "Toggle special workspace (magic)" })
hl.bind(mainMod .. " + SHIFT + slash", hl.dsp.window.move({ workspace = "special:magic" }), { description = "Move window to special workspace (magic)" })

-- Scripts
hl.bind(mainMod .. " + F1", function()
    local animations = (hl.get_config("animations.enabled") == false)

    if animations then
        hl.exec_cmd("hyprctl reload")
        return
    end

    hl.config({
        animations = {
            enabled = false
        }
    })
end, { description = "Toggle no animations" })
hl.bind(mainMod .. " + CTRL + F1", function()
    local game_mode = (hl.get_config("animations.enabled") == false)

    if game_mode then
        hl.exec_cmd("hyprctl reload")
        return
    end

    hl.config({
        general = {
            gaps_in = 0,
            gaps_out = 0,
            border_size = 1
        },
        animations = {
            enabled = false
        },
        decoration = {
            shadow = { enabled = true },
            blur = { enabled = true },
            rounding = 0
        }
    })
end, { description = "Toggle gamemode" })

-- Multimedia
-- hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%; notify-send -a 'Brightnessctl' -i 'brightness' -h int:value:\"$(brightnessctl -m | cut -d, -f4 | tr -d %)\" 'Brightness' \"$(brightnessctl -m | cut -d, -f4 | tr -d %)%\" -t 3000 -e"), { locked = true, repeating = true })
-- hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-; notify-send -a 'Brightnessctl' -i 'brightness' -h int:value:\"$(brightnessctl -m | cut -d, -f4 | tr -d %)\" 'Brightness' \"$(brightnessctl -m | cut -d, -f4 | tr -d %)%\" -t 3000 -e"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"), { locked = true, repeating = true, description = "Increase brightness" })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true, description = "Decrease brightness" })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"), { locked = true, repeating = true, description = "Increase volume" })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"), { locked = true, repeating = true, description = "Decrease volume" })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, description = "Play/Pause media" })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl pause"), { locked = true, description = "Stop media" })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause"), { locked = true, description = "Pause media" })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true, description = "Previous media track" })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true, description = "Next media track" })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"), { locked = true, repeating = true, description = "Toggle microphone mute" })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"), { locked = true, repeating = true, description = "Toggle volume mute" })

-- Movement & Focus
local move_keys = { left = "left", right = "right", up = "up", down = "down", H = "left", L = "right", K = "up", J = "down" }
for key, dir in pairs(move_keys) do
    -- Dont bind K,J for layout specific bindings below
    if key ~= "K" and key ~= "J" then
        hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ direction = dir }), { description = "Focus window in direction" })
    end
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = string.sub(dir, 1, 1) }), { description = "Move window in direction" })
end

hl.bind(mainMod .. " + J", layout_bind({
    scrolling = hl.dsp.focus({ direction = "down" }),
    dwindle   = hl.dsp.focus({ direction = "down" }),
    monocle   = hl.dsp.layout("cyclenext"),
    master    = hl.dsp.layout("cyclenext"),
}))
hl.bind(mainMod .. " + K", layout_bind({
    scrolling = hl.dsp.focus({ direction = "up" }),
    dwindle   = hl.dsp.focus({ direction = "up" }),
    monocle   = hl.dsp.layout("cycleprev"),
    master    = hl.dsp.layout("cycleprev"),
}))

hl.bind(mainMod .. " + SHIFT + tab", hl.dsp.window.cycle_next({ next = false }), { description = "Cycle to previous window" })
hl.bind(mainMod .. " + tab", hl.dsp.window.cycle_next(), { description = "Cycle to next window" })
hl.bind("ALT + Tab", hl.dsp.exec_cmd("noctalia msg window-switcher"), { description = "Window switcher"})

-- Resize windows
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true, description = "Resize window right" })
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true, description = "Resize window left" })
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true, description = "Resize window up" })
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.resize({ x = 0, y = 30, relative = true }), { repeating = true, description = "Resize window down" })

-- Workspaces
for i = 1, 10 do
    local key = tostring(i % 10)
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }), { description = "Focus workspace " .. i })
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }), { description = "Move window to workspace " .. i })
    hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = i, follow = false }), { description = "Move window to workspace " .. i .. " silently" })
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "m+1" }), { description = "Scroll to next workspace" })
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "m-1" }), { description = "Scroll to previous workspace" })
hl.bind(mainMod .. " + I", hl.dsp.focus({ workspace = "m+1" }), { description = "Focus next workspace on monitor" })
hl.bind(mainMod .. " + U", hl.dsp.focus({ workspace = "m-1" }), { description = "Focus previous workspace on monitor" })
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.focus({ workspace = "e+1" }), { description = "Focus next empty workspace" })
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.focus({ workspace = "e-1" }), { description = "Focus previous empty workspace" })
hl.bind(mainMod .. " + grave", hl.dsp.focus({ workspace = "previous" }), { description = "Focus previous workspace" })

-- Empty workspace
hl.bind(mainMod .. " + minus", hl.dsp.focus({ workspace = "empty"}), { description = "Focus next empty workspace" })
hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.window.move({ workspace = "empty"}), { description = "Move window to next empty workspace" })
hl.bind(mainMod .. " + CTRL + minus", function()
    hl.dispatch(hl.dsp.window.move({ workspace = "empty", follow = false }))

    -- Send a desktop notification
    hl.notification.create({
        text = "Window moved to an empty workspace",
        timeout = 2500,
        icon = "info",
        font_size = 13
    })
end, { description = "Move window to next empty workspace silently" })

-- Monitor movement
hl.bind(mainMod .. " + comma", hl.dsp.focus({ monitor = "l" }), { description = "Focus left monitor" })
hl.bind(mainMod .. " + period", hl.dsp.focus({ monitor = "r" }), { description = "Focus right monitor" })
hl.bind(mainMod .. " + SHIFT + comma", hl.dsp.window.move({ monitor = "-1" }), { description = "Move window to previous monitor" })
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.window.move({ monitor = "+1" }), { description = "Move window to next monitor" })
hl.bind(mainMod .. " + CTRL + comma", hl.dsp.workspace.move({ monitor = "l" }), { description = "Move workspace to left monitor" })
hl.bind(mainMod .. " + CTRL + period", hl.dsp.workspace.move({ monitor = "r" }), { description = "Move workspace to right monitor" })

-- Mouse binds
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Drag window" })
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.float(), { mouse = true, click = true, description = "Toggle window float (click)" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })

