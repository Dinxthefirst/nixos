{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellInit = ''
      fastfetch -c ~/.config/fastfetch/config.json -l nixos_small

      autoload -U colors && colors

      precmd() {
        print -P "%{$fg_bold[blue]%}%~%{$reset_color%}"
      }

      PROMPT="> "

      autoload -Uz compinit
      compinit

      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

      bindkey '^[[1;5D' backward-word
      bindkey '^[[1;5C' forward-word
      bindkey '^[[3~' delete-char
      bindkey '^[[3;5~' kill-word
      bindkey '^H' backward-kill-word

      mkcd() = mkdir -p "$1" | cd "$1"
      pdf() = zen-browser "$1" &
    '';

    # history.size = 10000;

    shellAliases = {
      config = "code ~/.config/nixos";
      rebuild = "~/rebuild.sh";
      p = "ping archlinux.org";
      ls = "ls --color=auto -v";
      ll = "ls -la --color=auto";
      la = "ls -a --color=auto";
    };
  };
}
