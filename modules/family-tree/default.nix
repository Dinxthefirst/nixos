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

      virtualHosts."oliver-toft.dk".extraConfig = ''
        reverse_proxy 127.0.0.1:3000
      '';
    };

    networking.firewall.allowedTCPPorts = [80 443];

    systemd.services.family-tree = {
      description = "Family Tree website";
      wantedBy = [];
      after = ["network.target"];

      serviceConfig = {
        WorkingDirectory = "/home/toft/projects/family-tree";
        ExecStart = "${pkgs.nodejs}/bin/node build";
        Environment = [
          "HOST=127.0.0.1"
          "PORT=3000"
          "NODE_ENV=production"
        ];
        Restart = "on-failure";
      };
    };
  };
}
