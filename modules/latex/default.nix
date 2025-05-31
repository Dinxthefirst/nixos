{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.latex;
in {
  options = {
    modules.latex.enable = mkEnableOption "latex";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (texlive.combine {inherit (texlive) scheme-full;})
    ];
  };
}
