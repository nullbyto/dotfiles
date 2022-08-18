local wibox = require('wibox')
local watch = require('awful.widget.watch')
local beautiful = require('beautiful')
local dpi = require('beautiful').xresources.apply_dpi
local awful = require("awful")

local brightness = wibox.widget.textbox()
local font = "Font Awesome 6 Free"

watch([[bash -c "brightnessctl | grep -oP '[^()]+%'"]], 2, function(_, stdout)
    brightness.text = stdout
    collectgarbage('collect')
end)

--return brightness
brightness_icon = wibox.widget {
	markup = '<span font="' .. font .. '"> </span>',
	widget = wibox.widget.textbox,
}
return wibox.widget {
	wibox.widget{
		brightness_icon,
		--fg = colors.brightyellow,
		widget = wibox.container.background
	},
    wibox.widget{
        brightness, 
        --fg = colors.brightyellow,
        widget = wibox.container.background
    },
    buttons = awful.util.table.join(
                awful.button({}, 4, function()
                    awful.spawn("brightnessctl set +5%", false) -- scroll up
                end),
                awful.button({}, 5, function()
                    awful.spawn("brightnessctl set 5%-", false) -- scroll down
                end)
            ),
    spacing = dpi(2),
    layout = wibox.layout.fixed.horizontal
}
