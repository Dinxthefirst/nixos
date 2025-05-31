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
  options = {
    modules.hyprland.enable = mkEnableOption "hyprland";
  };

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
    };

    environment.systemPackages = with pkgs; [
      waybar
      alacritty
      hyprpaper
      rofi-wayland
    ];
  };
}
