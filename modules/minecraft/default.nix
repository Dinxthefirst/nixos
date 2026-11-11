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
    nixpkgs.overlays = [
      (final: prev: {
        terracotta = prev.terracotta.overrideAttrs (old: {
          nativeBuildInputs = (old.nativeBuildInputs or []) ++ [final.pkg-config];
          buildInputs = (old.buildInputs or []) ++ [final.zstd];
          env = (old.env or {}) // {ZSTD_SYS_USE_PKG_CONFIG = "1";};
        });
      })
    ];
    networking.firewall.allowedTCPPorts = [25565];
  };
}
