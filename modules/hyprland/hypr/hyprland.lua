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

        accel_profile = "flat",
        sensitivity = -0.6, -- -1.0 - 1.0, 0 means no modification.
    },
})
-- Keybindings
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("ghostty"))
hl.bind("SUPER + B", hl.dsp.exec_cmd("$browser"))
hl.bind("SUPER + Q", hl.dsp.kill_active())
hl.bind("SUPER + SHIFT + Q", hl.dsp.force_kill_active())
hl.bind("SUPER + CTRL + M", hl.dsp.exit())
hl.bind("SUPER + M", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + SHIFT + M", hl.dsp.exit())
hl.bind("SUPER + E", hl.dsp.exec_cmd("$fileManager"))
hl.bind("SUPER + V", hl.dsp.toggle_floating())
hl.bind("SUPER + R", hl.dsp.exec_cmd("$menu"))
hl.bind("SUPER + F", hl.dsp.fullscreen())
hl.bind("SUPER + W", hl.dsp.exec_cmd("pkill waybar || waybar"))
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))

-- Move focus with arrow keys
hl.bind("SUPER + left", hl.dsp.move_focus("l"))
hl.bind("SUPER + H", hl.dsp.move_focus("l"))
hl.bind("SUPER + right", hl.dsp.move_focus("r"))
hl.bind("SUPER + L", hl.dsp.move_focus("r"))
hl.bind("SUPER + up", hl.dsp.move_focus("u"))
hl.bind("SUPER + K", hl.dsp.move_focus("u"))
hl.bind("SUPER + down", hl.dsp.move_focus("d"))
hl.bind("SUPER + J", hl.dsp.move_focus("d"))

-- Workspace switching
for i = 1, 10 do
    local key = i == 10 and "0" or tostring(i)
    hl.bind("SUPER + " .. key, hl.dsp.workspace(i))
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.move_to_workspace(i))
end

-- Special workspace (scratchpad)
hl.bind("SUPER + S", hl.dsp.toggle_special_workspace("magic"))
hl.bind("SUPER + SHIFT + S", hl.dsp.move_to_workspace("special:magic"))

-- Scroll through workspaces
hl.bind("SUPER + mouse_up", hl.dsp.workspace("e+1"))
hl.bind("SUPER + mouse_down", hl.dsp.workspace("e-1"))

-- Move/resize windows
hl.bind("SUPER + mouse:272", hl.dsp.move_window())
hl.bind("SUPER + mouse:273", hl.dsp.resize_window())

-- Multimedia keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"))

-- Playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))