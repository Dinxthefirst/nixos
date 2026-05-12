{
  pkgs,
  lib,
  config,
  specialArgs,
  ...
}:
with lib; let
  user = specialArgs.user;
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
      declarative = true;
      package = pkgs.minecraft-server;
      serverProperties = {
        server-ip = "";
        server-port = 25565;
      };
      dataDir = "/home/${user}/minecraft-server";
    };
  };
}
