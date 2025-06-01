{
  description = "NixOS config flake";

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    mkConfig = hostname:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./modules/system/configuration.nix
          ./hosts/${hostname}/hardware-configuration.nix
          ./hosts/${hostname}/user.nix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            networking.hostName = "nixos";
            home-manager = {
              extraSpecialArgs = {inherit inputs;};
              users.toft.home = {
                username = "toft";
                homeDirectory = "/home/toft";
                stateVersion = "25.05";
              };
              backupFileExtension = "backup";
            };

            users.users.toft = {
              isNormalUser = true;
              extraGroups = ["networkmanager" "wheel"];
            };
          }
        ];
      };
  in {
    nixosConfigurations = {
      laptop = mkConfig "laptop";
      desktop = mkConfig "desktop";
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    creamlinux = {
      url = "github:Novattz/creamlinux-installer";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  nixConfig = {
    experimental-features = ["nix-command" "flakes"];
    allowUnfree = true;
    trusted-users = ["root" "toft"];
  };
}
