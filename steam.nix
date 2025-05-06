{
  inputs,
  pkgs,
  ...
}: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    gamescopeSession.enable = true;
  };

  environment.systemPackages = with pkgs; [
    mangohud
    scarab # hollow knight mod manager
    inputs.creamlinux.packages.${pkgs.system}.default
  ];

  programs.gamemode.enable = true;
}
