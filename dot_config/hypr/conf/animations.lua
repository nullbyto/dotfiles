-- ==========================================
-- Animations
-- ==========================================
-- Custom curves mapped from original config (0.05, 0.9, 0.1, 1.05) -> { {x1, y1}, {x2, y2} }
hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.curve("overshot", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.1}  } })

hl.animation({ leaf = "windows",     enabled = true, speed = 3,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 2,  bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 2,  bezier = "default" })

