{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.gnome;
in {
  options = {
    modules.gnome.enable = mkEnableOption "gnome";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    environment.systemPackages = with pkgs; [
      gnome-tweaks
      gnome-extension-manager
      gnomeExtensions.blur-my-shell
      gnomeExtensions.appindicator
      gnomeExtensions.clipboard-indicator
    ];

    environment.gnome.excludePackages = with pkgs; [
      baobab # disk usage analyzer
      cheese # photo booth
      eog # image viewer
      epiphany # web browser
      gedit # text editor
      simple-scan # document scanner
      totem # video player
      yelp # help viewer
      evince # document viewer
      file-roller # archive manager
      geary # email client
      seahorse # password manager

      # these should be self explanatory
      # gnome-calculator
      gnome-calendar
      gnome-characters
      gnome-clocks
      gnome-contacts
      gnome-font-viewer
      gnome-logs
      gnome-maps
      gnome-music
      gnome-photos
      gnome-screenshot
      # gnome-system-monitor
      gnome-weather
      gnome-disk-utility
      pkgs.gnome-connections
    ];

    systemd.user.services.move-to-workspace = {
      description = "Move active window to specified workspace";
      script = ''
        #!/bin/sh
        WORKSPACE_INDEX=\$1
        gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell --method org.gnome.Shell.Eval "global.get_window_actors().forEach(actor => { if (actor.meta_window.has_focus()) { actor.meta_window.change_workspace_by_index(\$WORKSPACE_INDEX, true); } });"
      '';
      wantedBy = ["default.target"];
    };

    home-manager.users.toft = {
      dconf.settings = {
        "org/gnome/desktop/wm/keybindings" = {
          switch-to-workspace-1 = ["<Super>1"];
          switch-to-workspace-2 = ["<Super>2"];
          switch-to-workspace-3 = ["<Super>3"];
          switch-to-workspace-4 = ["<Super>4"];
          switch-to-workspace-5 = ["<Super>5"];
          close = ["<Super>q"];
        };
        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/"
          ];
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          name = "Move to Workspace 1";
          command = "bash -c 'systemctl --user start move-to-workspace@0'";
          binding = "<Super><Shift>1";
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
          name = "Move to Workspace 2";
          command = "bash -c 'systemctl --user start move-to-workspace@1'";
          binding = "<Super><Shift>2";
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
          name = "Move to Workspace 3";
          command = "bash -c 'systemctl --user start move-to-workspace@2'";
          binding = "<Super><Shift>3";
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
          name = "Move to Workspace 4";
          command = "bash -c 'systemctl --user start move-to-workspace@3'";
          binding = "<Super><Shift>4";
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4" = {
          name = "Move to Workspace 5";
          command = "bash -c 'systemctl --user start move-to-workspace@4'";
          binding = "<Super><Shift>5";
        };
      };
    };
  };
}
