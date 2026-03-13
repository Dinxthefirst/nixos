{
  pkgs,
  lib,
  config,
  inputs,
  specialArgs,
  ...
}:
with lib; let
  cfg = config.modules.zen;
  user = specialArgs.user;
in {
  options = {
    modules.zen.enable = mkEnableOption "zen";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user} = {
      home.packages = [
        inputs.zen-browser.packages."x86_64-linux".default
      ];
    };
  };
}
