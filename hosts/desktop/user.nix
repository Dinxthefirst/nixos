{config, ...}: {
  imports = [
    ../../modules
  ];

  config.modules = {
    flatpak.enable = true;
    gnome.enable = true;
    discord.enable = true;
    steam.enable = true;
    stremio.enable = true;
    gaming.enable = true;
    latex.enable = true;
    nodejs.enable = true;
    git.enable = true;
  };
}
