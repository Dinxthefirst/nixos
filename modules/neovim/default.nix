{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.neovim;
in {
  options = {
    modules.neovim.enable = mkEnableOption "neovim";
  };

  config = mkIf cfg.enable {
    home-manager.users.toft = {
      programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        extraConfig = lib.fileContents ./init.lua;
      };
    };
  };
}
