{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.family-tree;
in {
  options.modules.family-tree.enable = mkEnableOption "family-tree";

  config = mkIf cfg.enable {
    services.caddy = {
      enable = true;
      email = "olivertoftk@live.dk";
      virtualHosts."oliver-toft.dk".extraConfig = ''
        reverse_proxy 127.0.0.1:3000
      '';
      virtualHosts."www.oliver-toft.dk".extraConfig = ''
        redir https://oliver-toft.dk{uri} permanent
      '';
    };

    systemd.services.family-tree = {
      serviceConfig = {
        User = "toft";
        ExecStart = "/home/toft/.local/share/deploy/family-tree/bin/family-tree";
        Restart = "no";
      };
      environment = {
        PORT = "3000";
        HOST = "127.0.0.1";
      };
    };

    networking.firewall.allowedTCPPorts = [80 443];
  };
}
