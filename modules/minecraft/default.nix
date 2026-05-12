{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.minecraft;
in {
  options = {
    modules.minecraft.enable = mkEnableOption "minecraft";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      hmcl
    ];
    services.minecraft-server = {
      enable = false;
      eula = true;
      openFirewall = true;
      package = pkgs.minecraft-server;
      serverProperties = {
        server-ip = "";
        server-port = 25565;
      };
    };
  };
}
