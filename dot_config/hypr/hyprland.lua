-- ==========================================
-- Main configuration entrypoint
-- ==========================================

-- Optional plugins
pcall(require, "conf.plugins")

-- Display and monitor layouts
require("monitors")

-- Global configuration variables: modkey, terminal ...
require("conf.variables")

-- Wayland and hyprland environment variables
require("conf.env")

-- Startup applications/scripts
require("conf.autostart")

-- General hyprland settings: gaps, borders ...
require("conf.general")

-- Input devices settings
require("conf.devices")

-- Animations
require("conf.animations")

-- Keyboard shortcuts
require("conf.keybinds")

-- Window, workspace and layer rules
require("conf.rules")
