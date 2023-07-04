{
  description = "Mark's Nix system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
   
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

   # hyprland = {
   #   url = "github:hyprwm/Hyprland";
   # };

    emacs = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    }; 
  };

  outputs = { nixpkgs, home-manager, emacs, ... }:
    let
      system = "x86_64-linux";
      username = "mwood";
      pkgsForSystem = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = [
          emacs.overlays.default
	  #(self: super: {
	  #  waybar = super.waybar.overrideAttrs (oldAttrs: {
	  #    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
	  #  });
	  #})
        ];
      };

      lib = nixpkgs.lib;

    in {
      nixosConfigurations = {
         tinky = lib.nixosSystem {
           inherit system;
           pkgs = pkgsForSystem;
           modules = [
             ./systems/tinky/configuration.nix
             home-manager.nixosModules.home-manager
             #hyprland.nixosModules.default
             {
               home-manager.useGlobalPkgs = true;
               home-manager.useUserPackages = true;
               home-manager.users.mwood = import ./home/home.nix;
             }
           ];
         };
      };
    };
}
