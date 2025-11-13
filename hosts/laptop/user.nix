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
      latex.enable = true;
      hyprland.enable = false;
      gnome.enable = true;
      network.enable = true;
      git.enable = true;
      zsh.enable = true;
      vscode.enable = true;
      direnv.enable = true;
      obsidian.enable = true;
      docker.enable = true;
      flatpak.enable = true;
      nvim.enable = true;
      tmux.enable = true;
    };
  };
}
