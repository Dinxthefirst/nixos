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
  };
}
