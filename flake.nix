{
  description = "NixOS config flake";

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    user = "toft";
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
            system.stateVersion = "25.11";
            networking.hostName = "nixos";
            home-manager = {
              extraSpecialArgs = {inherit inputs;};
              users.${user}.home = {
                username = "${user}";
                homeDirectory = "/home/${user}";
                stateVersion = "25.11";
              };
              backupFileExtension = "backup";
            };

            users.users.${user} = {
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
    # creamlinux = {
    #   url = "github:Novattz/creamlinux-installer";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  nixConfig = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = ["root" "toft"];
  };
}
