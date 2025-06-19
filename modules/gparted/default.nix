{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.gparted;
in {
  options = {
    modules.gparted.enable = mkEnableOption "gparted";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gparted
      ntfs3g
    ];
  };
}
