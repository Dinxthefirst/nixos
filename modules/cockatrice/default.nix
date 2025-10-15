{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cockatrice;
in {
  options = {
    modules.cockatrice.enable = mkEnableOption "cockatrice";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      cockatrice
    ];
  };
}
