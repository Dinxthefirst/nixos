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

    history = {
      save = 1000;
      size = 1000;
      path = "$HOME/.cache/zsh_history";
    };
  };
}
