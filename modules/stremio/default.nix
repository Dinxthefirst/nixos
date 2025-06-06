{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.stremio;
in {
  options = {
    modules.stremio.enable = mkEnableOption "stremio";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      stremio
    ];
  };
}
