{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.obsidian;
in {
  options = {
    modules.obsidian.enable = mkEnableOption "obsidian";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.obsidian
    ];
  };
}
