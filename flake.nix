{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    hyprland.url = "github:hyprwm/Hyprland";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  outputs = { self, nixpkgs, zen-browser, hyprland, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs system; };
          modules = [
            inputs.home-manager.nixosModules.default
            ./laptop/hardware-configuration.nix
            ./laptop/packages.nix
            ./configuration.nix
            ./hyprland.nix
          ];
        };
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs system; };
          modules = [
            inputs.home-manager.nixosModules.default
            ./desktop/hardware-configuration.nix
            ./configuration.nix
            ./gnome.nix
            ./discord.nix
            ./steam.nix
          ];
        };
      };
    };
}
