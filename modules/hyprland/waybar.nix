{
  pkgs,
  lib,
  config,
  specialArgs,
  ...
}:
with lib; let
  cfg = config.modules.waybar;
  user = specialArgs.user;
in {
  options = {
    modules.waybar.enable = mkEnableOption "waybar";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user} = {
      programs.waybar = {
        enable = true;
        style = ./style.css;
        settings.main = {
          layer = "top";
          output = ["DP-1" "eDP-1"];
          position = "top";
          spacing = 0;
          height = 42;

          modules-left = [
            "hyprland/workspaces"
          ];
          modules-center = [
            "clock"
          ];
          modules-right = [
            "bluetooth"
            "network"
            "pulseaudio"
            "backlight"
            "battery"
          ];

          "hyprland/workspaces" = {
            format = "{name}: {icon}";
            format-icons = {
              active = "";
              default = "";
            };
          };

          bluetooth = {
            format = "󰂲";
            "format-on" = "{icon}";
            "format-off" = "{icon}";
            "format-connected" = "{icon} {device_battery_percentage}%";
            "format-icons" = {
              on = "󰂯";
              off = "󰂲";
              connected = "󰂱";
              battery = [
                "󰁺"
                "󰁻"
                "󰁼"
                "󰁽"
                "󰁾"
                "󰁿"
                "󰂀"
                "󰂁"
                "󰂂"
                "󰁹"
              ];
            };
            "on-click" = "blueman-manager";
            "tooltip-format-connected" = "{device_enumerate}";
          };

          clock = {
            timezone = "Europe/Copenhagen";
            interval = 1;
            format = "{:%H:%M:%S  -  %A  -  %Y-%m-%d}";
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            calendar = {
              mode = "year";
              mode-mon-col = 3;
              weeks-pos = "left";
              on-scroll = 1;
              on-click-right = "mode";
              format = {
                months = "<span color='#ffead3'><b>{}</b></span>";
                days = "<span color='#ecc6d9'><b>{}</b></span>";
                weeks = "<span color='#99ffdd'><b>W{}</b></span>";
                weekdays = "<span color='#ffcc66'><b>{}</b></span>";
                today = "<span color='#ff6699'><b><u>{}</u></b></span>";
              };
              actions = {
                on-click-right = "mode";
                on-click-forward = "tz_up";
                on-click-backward = "tz_down";
                on-scroll-up = "shift_up";
                on-scroll-down = "shift_down";
              };
            };
          };

          network = {
            "format-wifi" = "󰤢";
            "format-disconnected" = "󰤠";
            interval = 5;
            "tooltip-format" = "{essid} ({signalStrength}%)";
            "on-click" = "nm-connection-editor";
          };

          cpu = {
            interval = 1;
            format = "  {icon0}{icon1}{icon2}{icon3} {usage:>2}%";
            "format-icons" = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
            "on-click" = "ghostty -e htop";
          };

          memory = {
            interval = 30;
            format = "  {used:0.1f}G/{total:0.1f}G";
            "tooltip-format" = "Memory";
          };

          backlight = {
            format = "{icon}  {percent}%";
            "format-icons" = ["" "󰃜" "󰃛" "󰃞" "󰃝" "󰃟" "󰃠"];
            tooltip = false;
          };

          pulseaudio = {
            format = "{icon}  {volume}%";
            "format-muted" = "";
            "format-icons" = {
              default = ["" "" ""];
            };
            "on-click" = "pavucontrol";
          };

          battery = {
            interval = 2;
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon}  {capacity}%";
            "format-full" = "{icon}  {capacity}%";
            "format-charging" = " {capacity}%";
            "format-plugged" = " {capacity}%";
            "format-alt" = "{icon}  {time}";
            "format-icons" = ["" "" "" "" ""];
          };
        };
      };
    };
  };
}
