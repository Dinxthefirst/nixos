{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.gaming;
in {
  options = {
    modules.gaming.enable = mkEnableOption "gaming";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      heroic
      lutris
      wine
      winetricks
      glibc
      libadwaita
      gnutls
      alsa-lib
      vkd3d
      vulkan-loader
      vulkan-tools
      dxvk
    ];
  };
}
