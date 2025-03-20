{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    hyprland.url = "github:hyprwm/Hyprland";
    alejandra = {
      url = "github:kamadorueda/alejandra/3.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    experimental-features = ["nix-command" "flakes"];
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    zen-browser,
    hyprland,
    alejandra,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs system;};
        modules = [
          home-manager.nixosModules.home-manager
          ./laptop/hardware-configuration.nix
          ./laptop/packages.nix
          ./configuration.nix
          ./hyprland.nix
        ];
      };
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs system;};
        modules = [
          home-manager.nixosModules.home-manager
          ./desktop/hardware-configuration.nix
          ./desktop/drivers.nix
          ./configuration.nix
          ./gnome.nix
          ./discord.nix
          ./steam.nix
          ./stremio.nix
          ./latex.nix
          ./lutris.nix
        ];
      };
    };
  };
}
