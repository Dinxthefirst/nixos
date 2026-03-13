{
  pkgs,
  lib,
  config,
  specialArgs,
  ...
}:
with lib; let
  cfg = config.modules.ghostty;
  user = specialArgs.user;
in {
  options = {
    modules.ghostty.enable = mkEnableOption "ghostty";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user} = {
      programs.ghostty = {
        enable = true;

        enableZshIntegration = true;

        settings = {
          theme = "Abernathy";
          background-opacity = "0.75";
          font-family = "FiraCode Nerd Font Mono";
          font-size = "24";
        };
      };
    };
  };
}
