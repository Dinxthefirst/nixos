{ config, pkgs, inputs, ... }:

{
  home.username = "toft";
  home.homeDirectory = "/home/toft";

  home.stateVersion = "24.11"; 

  home.packages = [
    inputs.zen-browser.packages.${system}.default
  ];

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Oliver Toft";
    userEmail = "olivertoftk@live.dk";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      ms-vsliveshare.vsliveshare
    ];
  };
}
