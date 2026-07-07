{
  pkgs,
  lib,
  config,
  inputs,
  specialArgs,
  ...
}:
with lib; let
  cfg = config.modules.hyprland;
  hostname = specialArgs.hostname;
  user = specialArgs.user;
in {
  imports = [
    ./waybar.nix
  ];

  options.modules.hyprland.enable = mkEnableOption "hyprland";

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
      portalPackage = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".xdg-desktop-portal-hyprland;
    };

    xdg.portal.config.common.default = ["hyprland" "gtk"];

    modules.waybar.enable = true;

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
    };

    programs.hyprlock.enable = true;
    services.hypridle.enable = true;

    environment.systemPackages = with pkgs; [
      kdePackages.dolphin
      rofi
      hyprshot
      playerctl
      glib
    ];

    home-manager.users.${user} = {
      services.hyprpaper = {
        enable = true;
        settings = {
          preload = [
            "~/wallpapers/nix-wallpaper-nineish-catppuccin-macchiato-alt.png"
          ];
          wallpaper = [
            {
              monitor = "";
              path = "~/wallpapers/nix-wallpaper-nineish-catppuccin-macchiato-alt.png";
            }
          ];
        };
      };

      # home.file.".config/hypr/hyprland.conf".source = ./hypr/minimal.conf;
      home.file.".config/hypr/hyprland.conf".source = ./hypr/hyprland.conf;
      home.file.".config/hypr/monitors.conf".source = ./hypr/${hostname}/monitors.conf;
      home.file.".config/hypr/bindings.conf".source = ./hypr/bindings.conf;
      home.file.".config/hypr/input.conf".source = ./hypr/${hostname}/input.conf;
      home.file.".config/hypr/look.conf".source = ./hypr/look.conf;
    };
  };
}
