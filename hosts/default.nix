#
# This file contains the different profiles that can be used when building
# NixOS.
#

{ lib, inputs, nixpkgs, nixpkgs-unstable, home-manager, emacs, ... }:

let
  system = "x86_64-linux";         # Specify architecture

  # Configure the stable NixOS version
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;     # Allow proprietary software
#    overlays = [
#      (import emacs)
#    ];
  };

  # Configure unstable NixOS version
  unstable = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;     # Allow proprietary software
#    overlays = [
#      (import emacs)
#    ];
  };

  lib = nixpkgs.lib;
in
{
  # Define my system profiles
  #
  # Tinky
  #
  tinky = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs pkgs system;
      host = {
        hostName = "tinky";
      };
    };
    modules = [
      ./tinky
      ../system/configuration.nix
      ../system/mwood.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit pkgs emacs;
          host = {
            hostName = "tinky";
          };
        };
        home-manager.users.mwood = {
          imports = [
            ../users/mwood.nix
          ];
        };
      }
    ];
  };
  #
  # Nano
  #
  nano = lib.nixosSystem {
    inherit system;
    # Configure NixOS
    specialArgs = {
      inherit inputs pkgs system;
      host = {
        hostName = "nano";
      };
    };
    modules = [
      ./nano
      ../system/configuration.nix
      ../system/mwood.nix

      # Configure home manager
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit pkgs unstable emacs;
          host = {
            hostName = "nano";
          };
        };
        home-manager.users.mwood = {
          imports = [
            ../users/mwood.nix
          ];
        };
      }
    ];
  };
  #
  # Nano3
  #
  nano3 = lib.nixosSystem {
    inherit system;
    # Configure NixOS
    specialArgs = {
      inherit inputs pkgs system;
      host = {
        hostName = "nano3";
      };
    };
    modules = [
      ./nano3
      ../system/configuration.nix
      ../system/mwood.nix

      # Configure home manager
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit pkgs unstable emacs;
          host = {
            hostName = "nano3";
          };
        };
        home-manager.users.mwood = {
          imports = [
            ../users/mwood.nix
          ];
        };
      }
    ];
  };

}
