{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.ghostty;
in {
  options = {
    modules.ghostty.enable = mkEnableOption "ghostty";
  };

  config = mkIf cfg.enable {
    home-manager.users.toft = {
      programs.ghostty = {
        enable = true;

        enableZshIntegration = true;

        settings = {
          theme = "Abernathy";
          background-opacity = "0.75";
          font-family = "FiraCode Nerd Font Mono";
          font-size = "16px";
        };
      };
    };
  };
}
