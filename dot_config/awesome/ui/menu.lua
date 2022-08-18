local awful = require("awful")
local beautiful = require("beautiful")
local menubar = require("menubar")

-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mypowermenu = {
    { "lock", function() awful.spawn("betterlockscreen -l dimblur || i3lock || xlock", false) end },
    { "sleep", "systemctl suspend" },
    { "reboot" , {
            { "confirm", "reboot" }
        }
    },
    { "shutdown" , {
            { "confirm", "shutdown now" }
        }
    },
}


-- Third-part library
if pcall(require, "freedesktop") then
    local freedesktop = require("freedesktop")
    mymainmenu = freedesktop.menu.build({
        icon_size = beautiful.menu_height or 16,
        before = {
            { "Awesome", myawesomemenu, beautiful.awesome_icon },
        },
        after = {
            { "Power", mypowermenu },
            { "Open Terminal", terminal },
        }
    })
else
mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "power", mypowermenu },
                                    { "open terminal", terminal }
                                  }
                        })
end


mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
