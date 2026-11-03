{
  pkgs,
  lib,
  config,
  specialArgs,
  ...
}:
with lib; let
  family-tree = config.modules.family-tree;
  zsh = config.modules.zsh;
  user = specialArgs.user;
  inputs = specialArgs.inputs;
  web = inputs.family-tree.packages.${pkgs.stdenv.hostPlatform.system}.default;
  dir = "/var/lib/family-tree";
in {
  options.modules.family-tree.enable = mkEnableOption "family-tree";

  config = mkIf family-tree.enable {
    services.caddy = {
      enable = true;

      virtualHosts."oliver-toft.dk".extraConfig = ''
        encode zstd gzip
        header Strict-Transport-Security "max-age=31536000"
        reverse_proxy 127.0.0.1:3000
      '';
    };

    networking.firewall.allowedTCPPorts = [80 443];

    systemd.services.family-tree = {
      description = "Family Tree website";
      after = ["network.target"];

      serviceConfig = {
        ExecStart = "${web}/bin/family-tree";

        EnvironmentFile = "/etc/family-tree/production.env";
        Environment = [
          "HOST=127.0.0.1"
          "PORT=3000"
          "NODE_ENV=production"
          "ORIGIN=https://oliver-toft.dk"
          "ADDRESS_HEADER=X-Forwarded-For"
          "XFF_DEPTH=1"
          "BODY_SIZE_LIMIT=15M"
          "DATABASE_PATH=${dir}/family.db"
          "PHOTO_DIR=${dir}/photos"
        ];

        Restart = "on-failure";
        RestartSec = 5;

        User = "family-tree";
        Group = "family-tree";
        StateDirectory = "family-tree";
        WorkingDirectory = "${dir}";

        # hardening. no MemoryDenyWriteExecute, since node's JIT needs it
        NoNewPrivileges = true;
        PrivateTmp = true;
        ProtectSystem = "strict"; # StateDirectory stays writable
        ProtectHome = true;
        ProtectKernelTunables = true;
        ProtectControlGroups = true;
      };
    };

    # # daily snapshot. same disk, so copy it off the machine as well
    # systemd.services.family-tree-backup = {
    #   description = "Back up family tree data";
    #   serviceConfig = {
    #     Type = "oneshot";
    #     User = "family-tree";
    #     Group = "family-tree";
    #     StateDirectory = "family-tree";
    #   };
    #   script = ''
    #     set -euo pipefail
    #     dest=${dir}/backups
    #     out="$dest/$(date +%F_%H%M)"
    #     mkdir -p "$out"
    #     ${pkgs.sqlite}/bin/sqlite3 ${dir}/family.db ".backup '$out/family.db'"
    #     if [ -d ${dir}/photos ]; then
    #       ${pkgs.rsync}/bin/rsync -a ${dir}/photos/ "$dest/photos/"
    #     fi
    #     ls -1d "$dest"/20*/ | head -n -30 | xargs -r rm -rf
    #   '';
    # };

    # systemd.timers.family-tree-backup = {
    #   wantedBy = ["timers.target"];
    #   timerConfig = {
    #     OnCalendar = "03:00";
    #     Persistent = true; # runs at next boot if the machine was off
    #   };
    # };

    users.users.family-tree = {
      isSystemUser = true;
      group = "family-tree";
    };
    users.groups.family-tree = {};
    home-manager.users.${user}.programs.zsh.shellAliases = mkIf zsh.enable {
      website-on = "sudo systemctl start family-tree";
      website-off = "sudo systemctl stop family-tree";
      website-log = "journalctl -u family-tree -f";
    };
  };
}
