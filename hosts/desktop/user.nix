{config, ...}: {
  imports = [
    ../../modules
  ];

  config = {
    modules = {
      zen.enable = true;
      flatpak.enable = true;
      gnome.enable = true;
      discord.enable = true;
      steam.enable = true;
      stremio.enable = true;
      gaming.enable = true;
      latex.enable = true;
      nodejs.enable = true;
      git.enable = true;
      zsh.enable = true;
      vscode.enable = true;
      direnv.enable = true;
      obsidian.enable = true;
      minecraft.enable = true;
      gparted.enable = false;
      vm.enable = false;
      godot.enable = true;
      unity.enable = true;
    };
  };
}
