{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.family-tree;
  web = "/nix/store/xi3bj8s9qxzz9xrrg530i9910mh08pc8-family-tree-0.1.0";
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
        WorkingDirectory = "${web}";

        Environment = [
          "HOST=127.0.0.1"
          "PORT=3000"
          "NODE_ENV=production"
        ];

        Restart = "on-failure";
        User = "nobody";
      };
    };
  };
}
