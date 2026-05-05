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
          inherit inputs hostname user;
        };
        modules = [
          (inputs.import-tree ./modules)
          ./hosts/${hostname}/hardware-configuration.nix
          ./hosts/${hostname}/user.nix
          home-manager.nixosModules.home-manager
          {
            system.stateVersion = "26.05";
            networking.hostName = "nixos";
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit inputs;};
              users.${user}.home = {
                username = "${user}";
                homeDirectory = "/home/${user}";
                stateVersion = "26.05";
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
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    creamlinux = {
      url = "github:Novattz/creamlinux-installer/17ad517a459f1a41a40bef2642ee952859147ab5";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    import-tree.url = "github:vic/import-tree";
  };

  nixConfig = {
    extra-substituters = ["https://hyprland.cachix.org"];
    extra-trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
}
