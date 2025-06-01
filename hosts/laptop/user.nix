{
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

  imports = [
    ../../modules
  ];

  config.modules = {
    zen.enable = true;
    latex.enable = true;
    hyprland.enable = true;
    network.enable = true;
    git.enable = true;
    zsh.enable = true;
    vscode.enable = true;
    direnv.enable = true;
  };
}
