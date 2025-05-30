{
  description = "NixOS config flake";

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    # lib = nixpkgs.lib;
    # mkSystem = pkgs: system: hostname:
    #   pkgs.lib.nixosSystem {
    #     specialArgs = {
    #       inherit inputs system;
    #     };
    #     modules = [
    #       ./hosts/${hostname}/hardware-configuration.nix
    #       ./modules/system/configuration.nix
    #       ./hosts/${hostname}/user.nix
    #       home-manager.nixosModules.home-manager
    #       {
    #         networking.hostName = "nixos";
    #         home-manager = {
    #           useUserPackages = true;
    #           useGlobalPkgs = true;
    #           extraSpecialArgs = {inherit inputs;};
    #           users.toft = {
    #             imports = [
    #               ./home/programs
    #             ];
    #             home.username = "toft";
    #             home.homeDirectory = "/home/toft";
    #             home.packages = [
    #               inputs.zen-browser.packages."x86_64-linux".default
    #             ];
    #             home.stateVersion = "25.05";
    #           };
    #           backupFileExtension = "backup";
    #         };
    #         programs.zsh.enable = true;
    #         users.users.toft = {
    #           isNormalUser = true;
    #           description = "toft";
    #           extraGroups = ["networkmanager" "wheel"];
    #           shell = pkgs.zsh;
    #         };
    #       }
    #     ];
    #   };
  in {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs system;
        };
        modules = [
          ./hosts/laptop/hardware-configuration.nix
          ./modules/system/configuration.nix
          ./hosts/laptop/user.nix
          home-manager.nixosModules.home-manager
          {
            networking.hostName = "nixos";
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              extraSpecialArgs = {inherit inputs;};
              users.toft = {
                imports = [
                  ./home/programs
                ];
                home.username = "toft";
                home.homeDirectory = "/home/toft";

                home.packages = [
                  inputs.zen-browser.packages."x86_64-linux".default
                ];

                home.stateVersion = "25.05";
              };
              backupFileExtension = "backup";
            };

            programs.zsh.enable = true;

            users.users.toft = {
              isNormalUser = true;
              description = "toft";
              extraGroups = ["networkmanager" "wheel"];
              shell = pkgs.zsh;
            };
          }
        ];
      };
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs system;
        };
        modules = [
          ./hosts/desktop/hardware-configuration.nix
          ./modules/system/configuration.nix
          ./hosts/desktop/user.nix
          home-manager.nixosModules.home-manager
          {
            networking.hostName = "nixos";
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              extraSpecialArgs = {inherit inputs;};
              users.toft = {
                imports = [
                  ./home/programs
                ];
                home.username = "toft";
                home.homeDirectory = "/home/toft";

                home.packages = [
                  inputs.zen-browser.packages."x86_64-linux".default
                ];

                home.stateVersion = "25.05";
              };
              backupFileExtension = "backup";
            };

            programs.zsh.enable = true;

            users.users.toft = {
              isNormalUser = true;
              description = "toft";
              extraGroups = ["networkmanager" "wheel"];
              shell = pkgs.zsh;
            };
          }
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
    allowUnfree = true;
    trusted-users = ["root" "toft"];
  };
}
