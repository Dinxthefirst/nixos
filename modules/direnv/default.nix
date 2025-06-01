{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.direnv;
in {
  options = {
    modules.direnv.enable = mkEnableOption "direnv";
  };

  config = mkIf cfg.enable {
    home-manager.users.toft = {
      programs = {
        direnv = {
          enable = true;
          enableBashIntegration = true;
          nix-direnv.enable = true;
        };
      };
    };
  };
}
