-- ==========================================
-- Gestures & Devices
-- ==========================================
hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 4, direction = "vertical", action = "fullscreen", params = "none" })
hl.gesture({ fingers = 3, direction = "vertical", action = "fullscreen", mode = "maximize" })
hl.gesture({ fingers = 3, direction = "swipe", mods = "SUPER", action = "resize" })

