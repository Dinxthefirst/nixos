{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.zen;
in {
  options = {
    modules.zen.enable = mkEnableOption "zen";
  };

  config = mkIf cfg.enable {
    home-manager.users.toft = {
      home.packages = [
        inputs.zen-browser.packages."x86_64-linux".twilight
      ];
    };
  };
}
