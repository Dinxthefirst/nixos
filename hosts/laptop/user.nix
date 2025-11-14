{
  pkgs,
  config,
  ...
}: {
  imports = [
    ../../modules
  ];

  config = {
    environment.systemPackages = with pkgs; [
      brightnessctl
    ];
    modules = {
      zen.enable = true;
      latex.enable = false;
      hyprland.enable = false;
      gnome.enable = true;
      network.enable = true;
      git.enable = true;
      zsh.enable = true;
      vscode.enable = true;
      direnv.enable = true;
      obsidian.enable = true;
      docker.enable = false;
      flatpak.enable = true;
      neovim.enable = true;
      tmux.enable = true;
    };
  };
}
