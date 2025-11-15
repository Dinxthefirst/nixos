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
      };
      home.file.".config/nvim/settings.lua".source = ./init.lua;
    };
  };
}
