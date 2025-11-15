{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.bluetooth;
in {
  options = {
    modules.bluetooth.enable = mkEnableOption "bluetooth";
  };

  config = mkIf cfg.enable {
    services.blueman.enable = true;
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
        };
        Policy = {
          AutoEnable = true;
        };
      };
    };
  };
}
