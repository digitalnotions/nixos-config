#
# This file contains the different profiles that can be used when building
# NixOS.
#

{ lib, inputs, nixpkgs, nixpkgs-unstable, home-manager, user, location, emacs, ... }:

let
  system = "x86_64-linux";         # Specify architecture

  # Configure the stable NixOS version
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;     # Allow proprietary software
    overlays = [
      (import emacs)
    ];
  };

  # Configure unstable NixOS version
  unstable = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;     # Allow proprietary software
    overlays = [
      (import emacs)
    ];
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
      inherit inputs pkgs system user location;
      host = {
        hostName = "tinky";
      };
    };
    modules = [
      ./tinky
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit pkgs user emacs;
          host = {
            hostName = "tinky";
          };
        };
        home-manager.users.${user} = {
          imports = [
            ./home.nix
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
      inherit inputs pkgs system user location;
      host = {
        hostName = "nano";
      };
    };
    modules = [
      ./nano
      ./configuration.nix

      # Configure home manager
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit pkgs unstable user emacs;
          host = {
            hostName = "nano";
          };
        };
        home-manager.users.${user} = {
          imports = [
            ./home.nix
          ];
        };
      }
    ];
  };

}
