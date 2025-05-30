{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "toft";
  home.homeDirectory = "/home/toft";

  home.stateVersion = "25.05";

  home.packages = [
    inputs.zen-browser.packages."x86_64-linux".default
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
