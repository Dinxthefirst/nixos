{
  pkgs,
  lib,
  config,
  specialArgs,
  ...
}:
with lib; let
  cfg = config.modules.direnv;
  user = specialArgs.user;
in {
  options = {
    modules.direnv.enable = mkEnableOption "direnv";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user} = {
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
