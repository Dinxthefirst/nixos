{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.nodejs_23
  ];
}
