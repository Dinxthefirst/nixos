{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "toft";
  home.homeDirectory = "/home/toft";

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  home.packages = [
    inputs.zen-browser.packages."x86_64-linux".default
    pkgs.home-manager
  ];

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./git.nix
    ./vscode.nix
  ];

  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
  };
}
