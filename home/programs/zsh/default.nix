{pkgs, ...}: {
  home.packages = [
    pkgs.zsh
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      c = "clear";
      config = "code ~/.config/nixos";
      rebuild = "~/.config/nixos/rebuild.sh";
      p = "ping archlinux.org";
      ls = "ls --color=auto -v";
      ll = "ls -la --color=auto";
      la = "ls -a --color=auto";
    };

    initExtra = ''
      fastfetch -c ~/.config/fastfetch/config.json -l nixos_small

      autoload -U colors && colors

      precmd() {
        print -P "%{$fg_bold[blue]%}%~%{$reset_color%}"
      }

      PROMPT="> "

      bindkey '^[[1;5D' backward-word
      bindkey '^[[1;5C' forward-word
      bindkey '^[[3~' delete-char
      bindkey '^[[3;5~' kill-word
      bindkey '^H' backward-kill-word
    '';

    history = {
      save = 1000;
      size = 1000;
      path = "$HOME/.cache/zsh_history";
    };
  };
}
