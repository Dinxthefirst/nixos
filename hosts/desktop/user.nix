{config, ...}: {
  imports = [
    ../../modules
    ../../modules/discord.nix
    ../../modules/steam.nix
    ../../modules/stremio.nix
    ../../modules/latex.nix
    ../../modules/gaming.nix
    ../../modules/nodejs.nix
  ];

  config.modules = {
    flatpak.enable = true;
    gnome.enable = true;
  };
}
