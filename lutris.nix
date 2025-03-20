{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    lutris
    wine
  ];
}
