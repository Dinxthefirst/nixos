{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.tmux;
in {
  options = {
    modules.tmux.enable = mkEnableOption "tmux";
  };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      clock24 = true;
      baseIndex = 1;
      extraConfig = ''
        # used for less common options, intelligently combines if defined in multiple places.
      '';
    };
  };
}
