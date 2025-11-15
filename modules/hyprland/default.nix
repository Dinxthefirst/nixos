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
    ./waybar.nix
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

    modules = {
      alacritty.enable = true;
      waybar.enable = true;
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
    };

    programs.hyprlock.enable = true;
    services.hypridle.enable = true;

    environment.systemPackages = with pkgs; [
      hyprpaper
      kdePackages.dolphin
      rofi
    ];

    home-manager.users.toft = {
      home.file.".config/hypr/hyprland.conf".source = ./hypr/hyprland.conf;
      home.file.".config/hypr/monitors.conf".source = ./hypr/monitors.conf;
      home.file.".config/hypr/bindings.conf".source = ./hypr/bindings.conf;
      home.file.".config/hypr/input.conf".source = ./hypr/input.conf;
      home.file.".config/hypr/look.conf".source = ./hypr/look.conf;
    };
  };
}
