{
  config,
  pkgs,
  inputs,
  ...
}: {
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  imports = [
    ./gc.nix
    ./fonts.nix
    ./packages.nix
  ];

  time.timeZone = "Europe/Copenhagen";

  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };

  services = {
    libinput = {
      enable = true;
      touchpad.middleEmulation = false;
    };
    xserver = {
      synaptics.enable = false;
      xkb = {
        layout = "dk";
        variant = "nodeadkeys";
        options = "caps:escape_shifted_capslock";
      };
    };
  };

  # Configure console keymap
  console.keyMap = "dk-latin1";

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  programs.mepo.locationBackends.geoclue = false;
}
