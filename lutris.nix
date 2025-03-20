{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    lutris
    wine
    winetricks
    glibc
    libadwaita
    gnutls
    alsa-lib
    vkd3d
    vulkan-loader
  ];
}
