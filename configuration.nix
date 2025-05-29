{
  config,
  pkgs,
  inputs,
  target,
  ...
}: {
  imports = [
    ./boot.nix
    ./gc.nix
    ./fonts.nix
    ./packages.nix
  ];

  # nix.settings.experimental-features = ["nix-command" "flakes"];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users.toft = import ./home.nix;
    backupFileExtension = "backup";
  };

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
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

  services.xserver = {
    synaptics.enable = false;
    libinput = {
      enable = true;
      middleEmulation = false;
    };
    xkb = {
      layout = "dk";
      variant = "nodeadkeys";
    };
  };

  # Configure console keymap
  console.keyMap = "dk-latin1";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.toft = {
    isNormalUser = true;
    description = "toft";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  hardware.graphics.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  # system.stateVersion = "25.05";
}
