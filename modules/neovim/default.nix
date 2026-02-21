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
    environment.variables.EDITOR = "nvim";
    home-manager.users.toft = {
      programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        plugins = with pkgs; [
          vimPlugins.rose-pine
          vimPlugins.telescope-nvim
          vimPlugins.nvim-treesitter
          vimPlugins.undotree
        ];
      };
      home.file.".config/nvim/init.lua".source = ./init.lua;
      home.file.".config/nvim/lua/dinx/init.lua".source = ./lua/dinx/init.lua;
      home.file.".config/nvim/lua/dinx/options.lua".source = ./lua/dinx/options.lua;
      home.file.".config/nvim/lua/dinx/remaps.lua".source = ./lua/dinx/remaps.lua;
      home.file.".config/nvim/lua/dinx/plugin/colors.lua".source = ./lua/dinx/plugin/colors.lua;
      home.file.".config/nvim/lua/dinx/plugin/telescope.lua".source = ./lua/dinx/plugin/telescope.lua;
      # home.file.".config/nvim/lua/dinx/plugin/treesitter.lua".source = ./lua/dinx/plugin/treesitter.lua;
      home.file.".config/nvim/lua/dinx/plugin/undotree.lua".source = ./lua/dinx/plugin/undotree.lua;
    };
  };
}
