{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.git;
in {
  options = {
    modules.git.enable = mkEnableOption "git";
  };

  config = mkIf cfg.enable {
    home-manager.users.toft = {
      programs.git = {
        enable = true;
        userName = "Oliver Toft";
        userEmail = "olivertoftk@live.dk";
        extraConfig = {
          init.defaultBranch = "main";
          push.autoSetupRemote = true;
        };
      };
    };
  };
}
