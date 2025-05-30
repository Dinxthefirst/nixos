{pkgs, ...}: {
  # environment.systemPackages = with pkgs; [
  #   discord
  # ];

  services.flatpak.packages = [
    {
      appId = "com.discordapp.Discord";
      origin = "flathub";
    }
  ];
}
