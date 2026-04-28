{
  pkgs,
  lib,
  config,
  specialArgs,
  ...
}:
with lib; let
  user = specialArgs.user;
  cfg = config.modules.zoxide;
in {
  options = {
    modules.zoxide.enable = mkEnableOption "zoxide";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user} = {
      programs.zoxide.enable = true;
    };
  };
}
