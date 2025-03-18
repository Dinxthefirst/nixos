{ pkgs, system, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    firefox
    fastfetch
  ];
}