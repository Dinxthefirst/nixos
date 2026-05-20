{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vim
    firefox
    nurl
    fastfetch
    alejandra
    pavucontrol
  ];
}
