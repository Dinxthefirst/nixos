{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.family-tree;
  web = "/nix/store/h4s45yli87z3skggxywi6484976q6nyw-family-tree-0.1.0";
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

      after = ["network.target"];

      serviceConfig = {
        ExecStart = "${pkgs.nodejs}/bin/node ${web}/build";

        EnvironmentFile = "/etc/family-tree/production.env";
        Environment = [
          "HOST=127.0.0.1"
          "PORT=3000"
          "NODE_ENV=production"
        ];

        Restart = "on-failure";
        User = "family-tree";
        Group = "family-tree";
        StateDirectory = "family-tree";
        WorkingDirectory = "/var/lib/family-tree";
      };
    };

    users.users.family-tree = {
      isSystemUser = true;
      group = "family-tree";
    };
    users.groups.family-tree = {};
  };
}
