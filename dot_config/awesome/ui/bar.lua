local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
-- Third-party library
local lain = require("lain")

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     -- awful.button({ }, 1, function (c)
                     --                          if c == client.focus then
                     --                              c.minimized = true
                     --                          else
                     --                              c:emit_signal(
                     --                                  "request::activate",
                     --                                  "tasklist",
                     --                                  {raise = true}
                     --                              )
                     --                          end
                     --                      end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- ###############################################################################################
-- # Widgets
-- ###############################################################################################

-- Create a textclock widget
mytextclock = wibox.widget{
    format = " %a, %d/%m  %H:%M",
    buttons =  awful.util.table.join(
        awful.button({}, 1, function() -- left click
            awful.spawn(terminal .. " --class ikhal -e ikhal --color")
        end)
    ),
    widget = wibox.widget.textclock
}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

mykb_icon = wibox.widget{
    text = "",
    widget = wibox.widget.textbox,
    font = "Font Awesome 6 Free",
}


--------------------------------------------------------------------------------------------------
-- Lain widgets
local mycpu = lain.widget.cpu {
    settings = function()
        widget:set_markup(string.format("%2s%%", cpu_now.usage))
        widget:buttons(awful.util.table.join(
            awful.button({}, 1, function() -- left click
                awful.spawn("alacritty --class htop -e htop")
            end)
        ))
    end,
}

local mycpu_icon = wibox.widget{
    text = " ",
    widget = wibox.widget.textbox,
    font = "Font Awesome 6 Free",
    buttons = awful.util.table.join(
            awful.button({}, 1, function() -- left click
                awful.spawn("alacritty --class htop -e htop")
            end)
    ),
}


local mymem = lain.widget.mem {
    settings = function()
        widget:set_markup(string.format("%2s%%", mem_now.perc))
        widget:buttons(awful.util.table.join(
            awful.button({}, 1, function() -- left click
                awful.spawn("alacritty --class htop -e htop")
            end)
        ))
    end,
}

local mymem_icon = wibox.widget{
    text = " ",
    widget = wibox.widget.textbox,
    font = "Font Awesome 6 Free",
    buttons = awful.util.table.join(
            awful.button({}, 1, function() -- left click
                awful.spawn("alacritty --class htop -e htop")
            end)
    ),
}

local volume = lain.widget.alsa({
    settings = function()
        header = "墳 "
        vlevel = volume_now.level

        if volume_now.status == "off" then
            vlevel = "M"
        end


        widget:set_markup(header .. string.format("%2s", vlevel))
    end,

    timeout = 1
})

volume.widget:buttons(awful.util.table.join(
    awful.button({}, 3, function() -- right click
        -- awful.spawn(string.format("%s -e alsamixer", terminal))
        awful.spawn("pavucontrol")
    end),
    awful.button({}, 1, function() -- left click
        os.execute(string.format("%s set %s toggle", volume.cmd, volume.togglechannel or volume.channel))
        volume.update()
    end),
    awful.button({}, 4, function() -- scroll up
        --os.execute(string.format("%s set %s 1%%+", volume.cmd, volume.channel))
        os.execute("pactl set-sink-volume @DEFAULT_SINK@ +1%")
        volume.update()
    end),
    awful.button({}, 5, function() -- scroll down
        -- os.execute(string.format("%s set %s 1%%-", volume.cmd, volume.channel))
        os.execute("pactl set-sink-volume @DEFAULT_SINK@ -1%")
        volume.update()
    end)
))

--------------------------------------------------------------------------------------------------
-- Custom widgets

--local battery = require("widgets.battery")
local brightness = require("widgets.brightness")
local layout_textbox = require("widgets.textlayout")
local redshift = require("widgets.redshift")

local batt = require("widgets.battery-widget")
local bat0 = batt{
    adapter = "BAT0",
    ac = "AC",
    widget_text = "${AC_BAT}${percent}%",
    ac_prefix = {
        { 10, " " },
        { 20, " " },
        { 30, " " },
        { 40, " " },
        { 60, " " },
        { 80, " " },
        { 90, " " },
        { 100, " " },
    },
    battery_prefix = {
        { 10, " " },
        { 20, " " },
        { 30, " " },
        { 40, " " },
        { 50, " " },
        { 60, " " },
        { 70, " " },
        { 80, " " },
        { 90, " "  },
        { 100, " " },
    },
}

local bat1 = batt{
    adapter = "BAT1",
    ac = "AC",
    widget_text = "${AC_BAT}${percent}%",
    ac_prefix = {
        { 10, " " },
        { 20, " " },
        { 30, " " },
        { 40, " " },
        { 60, " " },
        { 80, " " },
        { 90, " " },
        { 100, " " },
    },
    battery_prefix = {
        { 10, " " },
        { 20, " " },
        { 30, " " },
        { 40, " " },
        { 50, " " },
        { 60, " " },
        { 70, " " },
        { 80, " " },
        { 90, " "  },
        { 100, " " },
    },
}

local mypower = wibox.widget{
    widget = wibox.widget.textbox,
    text = " ",
    font = "Font Awesome 6 Free",
    buttons = awful.util.table.join(
            awful.button({}, 1, function() -- left click
                awful.spawn("rofi -theme ~/.config/rofi/configPower.rasi -show power-menu -modi power-menu:~/.scripts/rofi-power-menu")
            end)
    ),
}

-- ###############################################################################################
-- # Setup
-- ###############################################################################################

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    -- set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "  ", "  ", "  ", "  ", "  ", "  ", "  ", " ﱦ ", "  ", "  " }, s, awful.layout.layouts[2])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
    }

    --s.mytaglistmod = require("widgets.taglist-mod")

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        margins = 20,
        filter  = awful.widget.tasklist.filter.focused,
        --filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ 
        position = "top", screen = s, height = 24
    })

    local sep = wibox.widget{
        text = " | ",
        widget = wibox.widget.textbox
    }
    local sep1 = wibox.widget{
        text = " |",
        widget = wibox.widget.textbox
    }
    local sep2 = wibox.widget{
        text = "| ",
        widget = wibox.widget.textbox
    }

    local space = wibox.widget{
        text = " ",
        widget = wibox.widget.textbox
    }

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            -- mylauncher,
            --space,
            --sep,
            s.mytaglist,
            --s.mytaglistmod(s),
            sep,
            --s.mylayoutbox,
            layout_textbox {},
            sep,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            space,
            wibox.widget.systray(),
            sep2,
            mycpu_icon,
            mycpu,
            space,
            mymem_icon,
            mymem,
            sep,
            redshift {},
            sep,
            brightness,
            sep,
            --battery,
            bat1,
            space,
            bat0,
            sep,
            volume,
            sep,
            mykb_icon,
            mykeyboardlayout,
            sep2,
            mytextclock,
            sep,
            mypower,
        },
    }
end)
