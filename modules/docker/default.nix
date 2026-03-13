{
  pkgs,
  lib,
  config,
  specialArgs,
  ...
}:
with lib; let
  cfg = config.modules.docker;
  user = specialArgs.user;
in {
  options = {
    modules.docker.enable = mkEnableOption "docker";
  };

  config = mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
    };
    users.users.${user}.extraGroups = ["docker"];
  };
}
