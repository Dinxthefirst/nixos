{
  pkgs,
  lib,
  config,
  specialArgs,
  ...
}:
with lib; let
  cfg = config.modules.darkman;
  user = specialArgs.user;
in {
  options.modules.darkman.enable = mkEnableOption "darkman";

  config = mkIf cfg.enable {
    home-manager.users.${user} = {
      services.darkman = {
        enable = true;
        settings = {
          lat = 56.15;
          lng = 10.21;
          usegeoclue = false;
        };
        lightModeScripts.gtk-theme = ''
          ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
        '';
        darkModeScripts.gtk-theme = ''
          ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
        '';
      };
    };
  };
}
