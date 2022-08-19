local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local taglist_underline_callback = function(self, _, index, _) -- adding this function
    local s = awful.screen.focused() -- Added since its outside the screen callback
    for _, x in pairs(s.selected_tags) do
      if x.index == index then
        --self:get_children_by_id("underline")[1].bg = "#ffffff" -- focused color
        self:get_children_by_id("underline")[1].bg = beautiful.border_focus -- focused color
        return
      end
    end
    --self:get_children_by_id("underline")[1].bg = "#212121" -- unfocused color
    self:get_children_by_id("underline")[1].bg = self:get_children_by_id("text_role")[1].bg -- unfocused color
end


function get_taglist(s)
    local s = s or awful.screen.focused()
    local mytaglist = awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.all,
        widget_template = { -- adding this property
            {
                {
                    layout = wibox.layout.fixed.vertical,
                    {
                        {
                          id = "text_role",
                          widget = wibox.widget.textbox,
                        },
                        widget = wibox.container.place,
                    },
                    {
                        {
                            -- width of tag button is left + right
                            left = 10,
                            right = 10,
                            -- height of underline
                            top = 2,
                            widget = wibox.container.margin,
                        },
                        id = "underline",
                        bg = "#ffffff",
                        shape = gears.shape.rectangle,
                        widget = wibox.container.background,
                    },
                },
                -- these are the margins around the underline
                -- replace 1 with 0 to have no margins
                left = 1,
                right = 1,
                widget = wibox.container.margin,
            },
            id = "background_role",
            widget = wibox.container.background,
            shape = gears.shape.rectangle,
            create_callback = taglist_underline_callback,
            update_callback = taglist_underline_callback,
        }
    })
    return mytaglist
end

return get_taglist

