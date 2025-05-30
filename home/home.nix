{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "toft";
  home.homeDirectory = "/home/toft";

  home.packages = [
    inputs.zen-browser.packages."x86_64-linux".default
  ];

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./programs
  ];

  home.stateVersion = "25.05";
}
