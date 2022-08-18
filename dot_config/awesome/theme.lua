-- Select theme name
local select = "gtk"

local theme = require("themes." .. select)

-- Overwrite theme variables
theme.useless_gap = 5
theme.tasklist_disable_icon = true
theme.border_width = 2
--theme.bg_focus = "#313244"
--theme.fg_focus = "#ffffff"
--theme.font = "TerminessTTF Nerd Font 13"
theme.taglist_font = "JetBrainsMono NL Nerd Font"
--theme.tasklist_font_focus = "TerminessTTF Nerd Font 13"
--theme.wibar_fg = "#bbbbbb"

-- Underline
--theme.bg_focus = theme.bg_normal
--theme.fg_focus = "#ffffff"

return theme
