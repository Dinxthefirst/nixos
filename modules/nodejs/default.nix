{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.nodejs;
in {
  options = {
    modules.nodejs.enable = mkEnableOption "nodejs";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.nodejs_23
    ];
  };
}
