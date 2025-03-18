{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "toft";
  home.homeDirectory = "/home/toft";

  home.stateVersion = "24.11";

  home.packages = [
    inputs.zen-browser.packages."x86_64-linux".default
  ];

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Oliver Toft";
    userEmail = "olivertoftk@live.dk";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      ms-vsliveshare.vsliveshare
      james-yu.latex-workshop
      esbenp.prettier-vscode
    ];
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
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
    '';

    history.size = 10000;

    shellAliases = {
      config = "code ~/.config/nixos";
      rebuild = "~/rebuild.sh";
      p = "ping archlinux.org";
      ls = "ls --color=auto -v";
      ll = "ls -la --color=auto";
      la = "ls -a --color=auto";
    };
  };

  home.file = {
    ".zsh_functions/mkcd".text = ''
      mkdir -p "$1"
      cd "$1"
    '';
    ".zsh_functions/pdf".text = ''
      zen-browser "$1" &
    '';
  };
}
