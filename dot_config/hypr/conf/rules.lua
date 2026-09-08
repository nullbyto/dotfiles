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
