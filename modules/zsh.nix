{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      config = "code ~/.config/nixos";
      rebuild = "~/.config/nixos/rebuild.sh";
      p = "ping archlinux.org";
      ls = "ls --color=auto -v";
      ll = "ls -la --color=auto";
      la = "ls -a --color=auto";
    };
  };
}
