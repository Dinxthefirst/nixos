{pkgs, ...}: {
  # environment.systemPackages = with pkgs; [
  #   discord
  # ];

  services.flatpak.packages = [
    "com.discordapp.Discord"
  ];
}
