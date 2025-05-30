{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    heroic
    lutris
    wine
    winetricks
    glibc
    libadwaita
    gnutls
    alsa-lib
    vkd3d
    vulkan-loader
    vulkan-tools
    dxvk
  ];
}
