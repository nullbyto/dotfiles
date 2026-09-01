-- ==========================================
-- Monitors
-- ==========================================
pcall(require, "monitors")

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

-- ==========================================
-- Variables
-- ==========================================
local mainMod = "SUPER"
local terminal = "kitty -1"
local fileManager = "thunar"
local browser = "vivaldi || vivaldi-stable"
local menu = "noctalia msg panel-toggle launcher"
local launcher = "noctalia msg panel-toggle launcher"
local screenshotDir = "~/Pictures/Screenshots"
local bar = "waybar"
local shell = "noctalia"
local lock = "noctalia msg session lock"
local oldLock = "hyprlock || swaylock -f -c 000000"

-- ==========================================
-- Environment variables
-- ==========================================
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_SIZE", 20)
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", 20)

-- ==========================================
-- Events (Autostart & Reload)
-- ==========================================
hl.on("hyprland.start", function()
    -- Auto login to kdewallet on login
    -- hl.exec_cmd("/usr/lib/pam_kwallet_init")
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd(shell)
    hl.exec_cmd("~/.config/hypr/scripts/xdg.sh")
    hl.exec_cmd("systemctl --user start xremap &")
    -- hl.exec_cmd("sleep 1 && awww-daemon")
    hl.exec_cmd("nm-applet &")
    hl.exec_cmd("blueman-applet &")
    hl.exec_cmd("emacs --daemon")
    hl.exec_cmd("/usr/lib/xfce-polkit/xfce-polkit &")
    hl.exec_cmd("XDG_CURRENT=GNOME insync start &")
    hl.exec_cmd("poweralertd -Ss &")
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 20")
    hl.exec_cmd("thunar --daemon")
end)

hl.on("config.reloaded", function()
    -- hl.exec_cmd("awww img ~/Pictures/Wallpapers/wallpaper.jpg")
end)

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
    cursor = { no_hardware_cursors = true },
    binds = {
        drag_threshold = 10 -- Fire a drag event only after dragging for more than 10px
    }
})

-- ==========================================
-- Gestures & Devices
-- ==========================================
hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 4, direction = "vertical", action = "fullscreen", params = "none" })
hl.gesture({ fingers = 3, direction = "vertical", action = "fullscreen", mode = "maximize" })
hl.gesture({ fingers = 3, direction = "swipe", mods = "SUPER", action = "resize" })

-- ==========================================
-- Animations
-- ==========================================
-- Custom Curves mapped from your original config (0.05, 0.9, 0.1, 1.05) -> { {x1, y1}, {x2, y2} }
hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.curve("overshot", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.1}  } })

hl.animation({ leaf = "windows",     enabled = true, speed = 3,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 2,  bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 2,  bezier = "default" })

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
hl.bind(mainMod .. " + S", function() hl.config({ general = { layout = "dwindle" }}) end)
hl.bind(mainMod .. " + T", function() hl.config({ general = { layout = "master" }}) end)

hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = "maximized"}))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen(), { description = "Toggle fullscreen" })
hl.bind(mainMod .. " + CTRL + F", hl.dsp.window.fullscreen_state({ internal = 2, client = -1 }), { description = "Fake fullscreen" })
hl.bind(mainMod .. " + CTRL + SHIFT + F", hl.dsp.window.fullscreen_state({ internal = -1, client = 2 }), { description = "Fake fullscreen (client only)" })

-- Special Workspaces
hl.bind(mainMod .. " + Z", hl.dsp.workspace.toggle_special("magic"), { description = "Toggle special workspace (magic)" })
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.window.move({ workspace = "special:magic" }), { description = "Move window to special workspace (magic)" })
hl.bind(mainMod .. " + slash", hl.dsp.workspace.toggle_special("magic"), { description = "Toggle special workspace (magic)" })
hl.bind(mainMod .. " + SHIFT + slash", hl.dsp.window.move({ workspace = "special:magic" }), { description = "Move window to special workspace (magic)" })

-- Scripts
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd("~/.config/hypr/scripts/noanim.sh"), { description = "Toggle no animations script" })
hl.bind(mainMod .. " + CTRL + F1", hl.dsp.exec_cmd("~/.config/hypr/scripts/gamemode.sh"), { description = "Toggle gamemode script" })

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
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ direction = dir }), { description = "Focus window in direction" })
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = string.sub(dir, 1, 1) }), { description = "Move window in direction" })
end

hl.bind(mainMod .. " + SHIFT + tab", hl.dsp.window.cycle_next({ next = false }), { description = "Cycle to previous window" })
hl.bind(mainMod .. " + tab", hl.dsp.window.cycle_next(), { description = "Cycle to next window" })

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

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Scroll to next workspace" })
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }), { description = "Scroll to previous workspace" })
hl.bind(mainMod .. " + I", hl.dsp.focus({ workspace = "m+1" }), { description = "Focus next workspace on monitor" })
hl.bind(mainMod .. " + U", hl.dsp.focus({ workspace = "m-1" }), { description = "Focus previous workspace on monitor" })
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.focus({ workspace = "e+1" }), { description = "Focus next empty workspace" })
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.focus({ workspace = "e-1" }), { description = "Focus previous empty workspace" })
hl.bind(mainMod .. " + grave", hl.dsp.focus({ workspace = "previous" }), { description = "Focus previous workspace" })

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

-- ==========================================
-- Window rules
-- ==========================================
local float_apps = {
    "^(xfce-polkit)$", "^(htop)$", "^(gdu)$", "^(nmtui)$", "^(ikhal)$",
    "^(Windscribe)$", "^(qalculate-gtk)$", "^(nm-connection-editor)$",
    "^(xarchiver)$", "^(xdg-desktop-portal-gtk)$", "^(gnome-power-statistics)$",
    "^(waypaper)$"
}
for _, app in ipairs(float_apps) do
    hl.window_rule({ match = { class = app }, float = true })
end
hl.window_rule({ match = { title = "^(.*Bitwarden.*)*" }, float = true })

hl.window_rule({ match = { class = "^(.*pavucontrol)$" }, float = true, center = true, size = "900 500" })
hl.window_rule({ match = { class = "^(.*edge.*)$" }, workspace = 2 })
hl.window_rule({ match = { class = "^(.*Vivaldi.*)$" }, workspace = 2 })
hl.window_rule({ match = { class = "^(.*discord.*)$" }, workspace = 9 })
hl.window_rule({ match = { fullscreen_state_client = 1 }, border_color = "rgb(50fa7b)" })

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Fix noctalia blur issues
hl.layer_rule({
  name = "noctalia",
  match = {
    namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
  },
  no_anim = true,
  ignore_alpha = 0.5,
  blur = true,
  blur_popups = true,
})
