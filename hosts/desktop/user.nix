{config, ...}: {
  imports = [
    ../../modules
  ];

  config = {
    modules = {
      zen.enable = true;
      flatpak.enable = false;
      gnome.enable = false;
      hyprland.enable = true;
      discord.enable = true;
      steam.enable = true;
      stremio.enable = true;
      gaming.enable = true;
      latex.enable = false;
      nodejs.enable = false;
      git.enable = true;
      zsh.enable = true;
      vscode.enable = true;
      direnv.enable = true;
      obsidian.enable = false;
      minecraft.enable = true;
      gparted.enable = true;
      vm.enable = false;
      godot.enable = false;
      unity.enable = false;
      docker.enable = false;
      cockatrice.enable = false;
      neovim.enable = true;
      tmux.enable = true;
      nvtop.enable = true;
      typst.enable = true;
      ghostty.enable = true;
    };
  };
}
