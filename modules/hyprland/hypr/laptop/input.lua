hl.config({
    input = {
        kb_layout  = "dk",
        kb_variant = "nodeadkeys",

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = true
        }
    },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace"})

hl.gesture({ fingers = 2, direction = "pinch", action = "cursorZoom", zoom_level = 2 })
hl.gesture({ fingers = 2, direction = "pinch", action = "cursorZoom", zoom_level = 1.2, mode = "mult" })
hl.gesture({ fingers = 2, direction = "pinch", action = "cursorZoom", zoom_level = 1, mode = "live" })