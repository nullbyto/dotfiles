-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
require("awful.autofocus")
local beautiful = require("beautiful")
package.loaded["naughty.dbus"] = {} -- Unload naughty to use dunst
local naughty = require("naughty")

-- ###############################################################################################

-- {{{ Error handling
require("config.errors")
-- }}}

-- ###############################################################################################

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")
--beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- Variables
terminal        = "alacritty"
home            = os.getenv("HOME")
editor          = os.getenv("EDITOR") or "nvim"
editor_cmd      = terminal .. " -e " .. editor
filemanager     = "thunar"
browser         = "firefox"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- ###############################################################################################

-- {{{ Menu
require("ui.menu")
-- }}}

-- {{{ Wibar
require("ui.bar")
-- }}}

-- {{{ titlebar
require("ui.titlebar")
-- }}}

-- {{{ Key and mouse bindings
require("config.bindings")
-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
require("config.rules")
-- }}}

-- {{{ Signals
require("config.signals")
-- }}}

-- Autostart programs
awful.spawn.with_shell("~/.config/awesome/autostart.sh")
