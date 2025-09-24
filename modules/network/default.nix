{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.network;
in {
  options = {
    modules.network.enable = mkEnableOption "network";
  };

  config = mkIf cfg.enable {
    networking.networkmanager.enable = true;
    systemd.services.NetworkManager-wait-online.enable = false;
    environment.systemPackages = with pkgs; [
      networkmanager-openvpn
    ];
  };
}
