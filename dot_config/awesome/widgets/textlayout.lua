local awful = require("awful")
local wibox = require("wibox")

local text_layout = {}

function text_layout:new(args)
    args = args or {}

    self.CUSTOM_LAYOUTS = {
        tile = args.tile or "[]=",
        fairv = args.fairv or "==",
        max = args.max or "[M]",
        floating = args.floating or "><>",
        dwindle = args.dwindle or "[\\\\]",
        spiral = args.spiral or "[@]",
    }

    self.layout_textbox = wibox.widget{
        widget = wibox.widget.textbox
    }

    self.args = args

    tag.connect_signal("property::layout", function()
                        text_layout:set_layout_text()
    end)
    tag.connect_signal("property::selected", function ()
                        text_layout:set_layout_text()
    end)

    self:set_layout_text()

    return self.layout_textbox
end


function text_layout:set_layout_text()
    local name = awful.layout.getname(awful.layout.get(awful.screen.focused()))
    if self.CUSTOM_LAYOUTS[name] ~= nil then
        self.layout_textbox:set_text(self.CUSTOM_LAYOUTS[name])
    elseif self.args[name] ~= nil then
        self.layout_textbox:set_text(self.args[name])
    else
        self.layout_textbox:set_text(name)
    end
end


return setmetatable(text_layout, {
    __call = text_layout.new,
})
