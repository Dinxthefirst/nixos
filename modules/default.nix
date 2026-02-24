{
  imports = [
    # ./system
    ./zen
    ./flatpak
    ./gnome
    ./discord
    ./steam
    ./stremio
    ./gaming
    ./latex
    ./hyprland
    ./nodejs
    ./network
    ./git
    ./zsh
    ./vscode
    ./direnv
    ./vm
    ./obsidian
    ./minecraft
    ./gparted
    ./godot
    ./unity
    ./docker
    ./cockatrice
    ./neovim
    ./tmux
    ./bluetooth
    ./nvtop
    ./typst
  ];
  # imports = builtins.map (name: ./${name}) (builtins.attrNames (builtins.filter (name: type: type == "directory") (builtins.readDir ./)));
}
