{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.zsh;
in {
  options = {
    modules.zsh.enable = mkEnableOption "zsh";
  };

  config = mkIf cfg.enable {
    programs.zsh.enable = true;

    users.users.toft.shell = pkgs.zsh;

    home-manager.users.toft = {
      home.packages = [
        pkgs.zsh
      ];

      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
          c = "clear";
          config = "code ~/.config/nixos";
          rebuild = "~/.config/nixos/rebuild.sh";
          p = "ping archlinux.org";
          ls = "ls --color=auto -v";
          ll = "ls -la --color=auto";
          la = "ls -a --color=auto";

          gs = "git status --short";
          gd = "git diff --output-indicator-new=' ' --output-indicator-old=' '";
          ga = "git add";
          gap = "git add --patch";
          gc = "git commit";
          gp = "git push";
          gu = "git pull";
          gl = "git log --all --graph --pretty=format:'%C(magenta)%h %C(white) %an  %ar%C(auto) %D%n%s%n'";
          gb = "git branch";
          gi = "git init";
          gcl = "git clone";
          gco = "git checkout";
        };

        initContent = ''
          fastfetch -c ~/.config/fastfetch/config.json -l nixos_small

          autoload -U colors && colors

          precmd() {
            print -P "%{$fg_bold[blue]%}%~%{$reset_color%}"
          }

          PROMPT="> "

          zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

          bindkey '^[[1;5D' backward-word
          bindkey '^[[1;5C' forward-word
          bindkey '^[[3~' delete-char
          bindkey '^[[3;5~' kill-word
          bindkey '^H' backward-kill-word

          mkcd() {
            mkdir -p "$1"
            cd "$1"
          }
          web() {
            zen "$1" &
          }
          np() {
            NIXPKGS_ALLOW_UNFREE=1 nix-shell -p "$1" --extra-experimental-features flakes
          }
        '';

        history = {
          save = 1000;
          size = 1000;
          path = "$HOME/.cache/zsh_history";
        };
      };
    };
  };
}
