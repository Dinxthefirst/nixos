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
      hyprland.enable = true;
      gnome.enable = false;
      network.enable = true;
      git.enable = true;
      zsh.enable = true;
      vscode.enable = true;
      direnv.enable = true;
      obsidian.enable = true;
      docker.enable = false;
      flatpak.enable = false;
      neovim.enable = true;
      tmux.enable = true;
      bluetooth.enable = true;
      vm.enable = true;
    };
  };
}
