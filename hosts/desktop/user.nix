{config, ...}: {
  imports = [
    ../../modules
    ../../modules/latex.nix
    ../../modules/gaming.nix
    ../../modules/nodejs.nix
  ];

  config.modules = {
    flatpak.enable = true;
    gnome.enable = true;
    discord.enable = true;
    steam.enable = true;
    stremio.enable = true;
  };
}
