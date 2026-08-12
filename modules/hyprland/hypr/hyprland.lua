-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

local terminal = "ghostty"
local browser = "zen"

hl.config({
    input = {
        kb_layout  = "dk",
        kb_variant = "nodeadkeys",

        accel_profile = "linear",
        sensitivity = -0.6, -- -1.0 - 1.0, 0 means no modification.
    },
})
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("ghostty"))
