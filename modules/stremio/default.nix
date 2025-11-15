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
    # nixpkgs.config.permittedInsecurePackages = [
    #   "qtwebengine-5.15.19"
    # ];
    environment.systemPackages = with pkgs; [
      stremio
    ];
  };
}
