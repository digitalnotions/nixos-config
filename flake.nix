#
# Personal configuration for NixOS and hopefully Darwin Flake in the future.
#
# The intention of this is to provide the same configuration across
# multiple computing devices.
#
# The following configurations exist:
#
#  - Laptop/Tinky: Lenovo ThinkPad x270 - used for Linux development and
#    testing purposes.
#
#  - Laptop/Nano: Lenovo ThinkPad Carbon Nano Gen 1 - super small laptop
#    that goes everywhere with me. Runs Windows in a VM for specific programs
#    that cannot run under Linux (mainly Ham radio software and Victron
#    charge controllers).
#
# This top level flake high level versions packages to ensure all
# configurations are equivalent.
#

{
  description = "Personal NixOS System Flake Configuration";

  inputs =
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";             # Default to Stable Nix packages
      nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable Nix packages

      home-manager = {                                              # Home package manager
        url = "github:nix-community/home-manager/release-23.05";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      emacs = {                                                     # Emacs overlays
        url = "github:nix-community/emacs-overlay";
        inputs.nixpkgs.follows = "nixpkgs";
        #flake = false;
      };
    };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, emacs, ... }:
    let
      user = "mwood";
      location = "$HOME/nixconfig";
    in
      {
        nixosConfigurations = (
          import ./hosts {
            inherit (nixpkgs) lib;
            inherit inputs nixpkgs nixpkgs-unstable home-manager emacs user location;
          }
        );
      };
}
