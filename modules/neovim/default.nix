{
  pkgs,
  lib,
  config,
  specialArgs,
  ...
}:
with lib; let
  cfg = config.modules.neovim;
  user = specialArgs.user;
in {
  options = {
    modules.neovim.enable = mkEnableOption "neovim";
  };

  config = mkIf cfg.enable {
    environment.variables.EDITOR = "nvim";
    home-manager.users.${user} = {
      programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        # LSP servers provisioned by Nix, not Mason
        extraPackages = with pkgs; [
          # add your LSPs here, e.g.:
          ripgrep
          lua-language-server
          nil # nix LSP
          rust-analyzer
          typescript-language-server
        ];
        plugins = with pkgs.vimPlugins; [
          rose-pine
          telescope-nvim
          plenary-nvim
          nvim-treesitter.withAllGrammars
          undotree
          nvim-lspconfig
          nvim-cmp
          cmp-nvim-lsp
          luasnip
          cmp_luasnip
        ];
        extraLuaConfig = ''
          require('dinx')
        '';
      };
      home.file.".config/nvim/lua/dinx/init.lua".source = ./lua/dinx/init.lua;
      home.file.".config/nvim/lua/dinx/options.lua".source = ./lua/dinx/options.lua;
      home.file.".config/nvim/lua/dinx/remaps.lua".source = ./lua/dinx/remaps.lua;
      home.file.".config/nvim/lua/dinx/plugin/colors.lua".source = ./lua/dinx/plugin/colors.lua;
      home.file.".config/nvim/lua/dinx/plugin/telescope.lua".source = ./lua/dinx/plugin/telescope.lua;
      home.file.".config/nvim/lua/dinx/plugin/treesitter.lua".source = ./lua/dinx/plugin/treesitter.lua;
      home.file.".config/nvim/lua/dinx/plugin/lsp.lua".source = ./lua/dinx/plugin/lsp.lua;
      home.file.".config/nvim/lua/dinx/plugin/completion.lua".source = ./lua/dinx/plugin/completion.lua;
      home.file.".config/nvim/lua/dinx/plugin/undotree.lua".source = ./lua/dinx/plugin/undotree.lua;
    };
  };
}
