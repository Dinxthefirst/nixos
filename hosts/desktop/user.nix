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
      stremio.enable = false;
      gaming.enable = true;
      latex.enable = false;
      nodejs.enable = false;
      git.enable = true;
      zsh.enable = true;
      vscode.enable = true;
      direnv.enable = true;
      obsidian.enable = true;
      minecraft.enable = true;
      gparted.enable = true;
      vm.enable = false;
      godot.enable = false;
      unity.enable = false;
      docker.enable = true;
      cockatrice.enable = false;
      neovim.enable = true;
      tmux.enable = true;
    };
  };
}
