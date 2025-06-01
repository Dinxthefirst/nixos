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
    latex.enable = true;
    hyprland.enable = true;
    network.enable = true;
    git.enable = true;
  };
}
