{ config, pkgs, inputs, ... }:

{
  home.username = "toft";
  home.homeDirectory = "/home/toft";

  home.stateVersion = "24.11"; 

  home.packages = [
    inputs.zen-browser.packages."x86_64-linux".default
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
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      ms-vsliveshare.vsliveshare
    ];
  };
}
