{
  pkgs,
  lib,
  config,
  specialArgs,
  ...
}:
with lib; let
  cfg = config.modules.vm;
  user = specialArgs.user;
in {
  options = {
    modules.vm.enable = mkEnableOption "vm";
  };

  config = mkIf cfg.enable {
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = ["${user}"];
  };
}
