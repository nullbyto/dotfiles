local awful = require("awful")
local wibox = require("wibox")


local layout_textbox = wibox.widget{
    widget = wibox.widget.textbox
}

local CUSTOM_LAYOUT_NAMES = {
    tile = "[]=",
    fairv = "==",
    max = "[M]",
    floating = "><>",
    dwindle = "[\\\\]",
    spiral = "[@]",
}

function set_layout_text()
    local name = awful.layout.getname(awful.layout.get(awful.screen.focused()))
    if CUSTOM_LAYOUT_NAMES[name] ~= nil then
        layout_textbox:set_text(CUSTOM_LAYOUT_NAMES[name])
    else
        layout_textbox:set_text(name)
    end
end

tag.connect_signal("property::layout", set_layout_text)
tag.connect_signal("property::selected", set_layout_text)

return layout_textbox
