local awful = require("awful")
local wibox = require("wibox")


local wg = {}

function wg:new(args)
    args = args or {}

    self.prefix    = args.prefix or " "
    self.off       = args.off or " off"
    self.default_temp = args.temp or 2500
    self.temp      = self.default_temp
    self.max       = args.max or 10000
    self.min       = args.min or 1000
    self.step      = args.step or 200
    self.enabled   = false

    self.widget = wibox.widget{
        text = self.off,
        widget = wibox.widget.textbox,
    }
   self.widget:buttons(awful.util.table.join(
        awful.button({}, 1, function() self:toggle() end),
        awful.button({}, 3, function()
                self.temp = self.default_temp
                self:update()
        end),
        awful.button({}, 4, function() self:increase() end),
        awful.button({}, 5, function() self:decrease() end)
    ))
    return self.widget
end

function wg:update()
    if self.enabled then
        awful.spawn.with_shell("redshift -P -O" .. self.temp)
        wg.widget:set_text(self.prefix .. self.temp .. "K")
    else
        awful.spawn.with_shell("redshift -x")
        wg.widget:set_text(self.off)
    end
end

function wg:increase()
    if self.temp + self.step <= self.max then
        self.temp = self.temp + self.step
    else
        self.temp = self.max
    end
    self.enabled = true
    self:update()
end

function wg:decrease()
    if self.temp - self.step >= self.min then
        self.temp = self.temp - self.step
    else
        self.temp = self.min
    end
    self.enabled = true
    self:update()
end

function wg:toggle()
    if self.enabled then
        self.enabled = false
        self:update()
    else
        self.enabled = true
        self:update()
    end
end

return setmetatable(wg, {
    __call = wg.new,
})
