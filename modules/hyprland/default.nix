{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.hyprland;
in {
  imports = [
    ./alacritty.nix
  ];

  options = {
    modules.hyprland.enable = mkEnableOption "hyprland";
  };

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    };

    modules.alacritty.enable = true;

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
    };

    environment.systemPackages = with pkgs; [
      hyprpaper
      rofi
    ];

    home-manager.users.toft = {
      wayland.windowManager.hyprland.settings = {
        "monitor" = "eDP-1, 2256x1504@60.00, 0x0, 1";

        "$terminal" = "alacritty";
        "$menu" = "rofi --show drun";
        "$browser" = "zen";

        "exec-once" = "waybar";

        decoration = {
          shadow_offset = "0 5";
          "col.shadow" = "rgba(00000099)";
        };

        "$mod" = "SUPER";

        bindm = [
          # mouse movements
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
          "$mod ALT, mouse:272, resizewindow"
        ];
      };

      programs.waybar = {
        enable = true;
        # /home/toft/.config/nixos/modules/hyprland/style.css
        style = ''
          #waybar {
            background: transparent;
            color: #ff6200ff;
            margin: 0px;
            font-weight: 500;
          }
        '';
        settings.main = {
          layer = "top";
          height = 35;
          spacing = 4;

          modules-left = [
            "hyprland/workspaces"
            "cpu"
          ];
          modules-center = ["clock"];
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
            "format-connected" = "{icon}";
            "format-icons" = {
              on = "󰂯";
              off = "󰂲";
              connected = "󰂱";
            };
            "on-click" = "blueman-manager";
            "tooltip-format-connected" = "{device_enumerate}";
          };

          clock = {
            timezone = "Europe/Copenhagen";
            tooltip = false;
            format = "{:%H:%M:%S  -  %A, %d}";
            interval = 1;
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
            "format-alt" = "{icon} {time}";
            "format-icons" = ["" "" "" "" ""];
          };
        };
      };
    };
  };
}
