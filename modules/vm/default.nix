{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.vm;
in {
  options = {
    modules.vm.enable = mkEnableOption "vm";
  };

  config = mkIf cfg.enable {
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = ["toft"];
  };
}
