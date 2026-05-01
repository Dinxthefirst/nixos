{
  pkgs,
  lib,
  config,
  specialArgs,
  ...
}:
with lib; let
  user = specialArgs.user;
  zoxide = config.modules.zoxide;
  zsh = config.modules.zsh;
in {
  options = {
    modules.zoxide.enable = mkEnableOption "zoxide";
  };

  config = mkIf zoxide.enable {
    home-manager.users.${user} = {
      programs.zoxide.enable = true;

      programs.zsh = mkIf zsh.enable {
        initContent = mkAfter ''
          eval "$(zoxide init zsh)"
        '';
      };

      programs.bash = mkIf (zsh.enable == false) {
        initExtra = mkAfter ''
          eval "$(zoxide init bash)"
        '';
      };
    };
  };
}
