local awful = require("awful")
local wibox = require("wibox")

local prefix    = " "
local off       = "off"
local temp      = 2500
local max       = 12000
local min       = 1000
local step      = 200
local enabled   = false

local wg = wibox.widget{
    text = prefix .. off,
    widget = wibox.widget.textbox,
}

local function update()
    if enabled then
        awful.spawn.with_shell("redshift -P -O" .. temp)
        wg:set_text(prefix .. temp .. "K")
    else
        awful.spawn.with_shell("redshift -x")
        wg:set_text(prefix .. off)
    end
end

local function increase()
    if temp + step <= max then
        temp = temp + step
    else
        temp = max
    end
    enabled = true
    update()
end

local function decrease()
    if temp - step >= min then
        temp = temp - step
    else
        temp = min
    end
    enabled = true
    update()
end

local function toggle()
    if enabled then
        enabled = false
        update()
    else
        enabled = true
        update()
    end
end


wg:buttons(awful.util.table.join(
        awful.button({}, 1, toggle),
        awful.button({}, 4, increase),
        awful.button({}, 5, decrease)
    )
)

return wg
