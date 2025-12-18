{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.nvtop;
in {
  options = {
    modules.nvtop.enable = mkEnableOption "nvtop";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nvtopPackages.amd
    ];
  };
}
