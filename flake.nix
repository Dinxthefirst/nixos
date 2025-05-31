{
  description = "NixOS config flake";

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-flatpak,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs system;
        };
        modules = [
          home-manager.nixosModules.home-manager
          ./hosts/laptop/hardware-configuration.nix
          ./hosts/laptop/user.nix
          ./modules/configuration.nix
          ./modules/hyprland.nix
          ./modules/zsh.nix
          ./modules/network.nix
          ./modules/latex.nix
        ];
      };
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs system;
        };
        modules = [
          home-manager.nixosModules.home-manager
          ./hosts/desktop/hardware-configuration.nix
          ./hosts/desktop/user.nix
          ./modules/configuration.nix
          nix-flatpak.nixosModules.nix-flatpak
          ./modules/flatpak.nix
          ./modules/gnome.nix
          ./modules/discord.nix
          ./modules/steam.nix
          ./modules/stremio.nix
          ./modules/latex.nix
          ./modules/zsh.nix
          ./modules/gaming.nix
          ./modules/nodejs.nix
        ];
      };
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    hyprland.url = "github:hyprwm/Hyprland";
    creamlinux = {
      url = "github:Novattz/creamlinux-installer";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  nixConfig = {
    experimental-features = ["nix-command" "flakes"];
  };
}
