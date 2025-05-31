{config, ...}: {
  imports = [
    ../../modules
    ../../modules/steam.nix
    ../../modules/stremio.nix
    ../../modules/latex.nix
    ../../modules/gaming.nix
    ../../modules/nodejs.nix
  ];

  config.modules = {
    flatpak.enable = true;
    gnome.enable = true;
    discord.enable = true;
  };
}
