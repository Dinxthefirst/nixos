{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

  imports = [
    ../../modules
    ../../modules/hyprland.nix
    ../../modules/network.nix
    ../../modules/latex.nix
  ];
}
