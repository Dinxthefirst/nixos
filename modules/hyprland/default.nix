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
      kdePackages.dolphin
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
    };
  };
}
