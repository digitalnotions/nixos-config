{ config, lib, pkgs, ... }:

{
  # Home manager needs a bit of information about you and the 
  # paths it should manage
  home.username = "mwood";
  home.homeDirectory = "/home/mwood";

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Mark Wood";
    userEmail = "mark@digitalnotions.net";
  };

  home.file.".local/bin" = {
    source = ../scripts;
    recursive = true;
  };

  # Put emacs files into home directory so the emacs daemon can pick them up
  home.file.".emacs.d" = {
    source = ./emacs/.emacs.d;
    recursive = true;
  };

  # Ensure that we use emacsclient as appropriate
  home.sessionVariables = {
    EDITOR = "${pkgs.emacs-git}/bin/emacsclient -t";
    VISUAL = "${pkgs.emacs-git}/bin/emacsclient -c";
  };

  # Configure zsh for shell
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    enableAutosuggestions = true;

    shellAliases = {
      ll = "ls -al";
      ec = "${pkgs.emacs-git}/bin/emacsclient -n -c";
      nixos_update = "pushd ~/nixconfig && sudo nix flake update && sudo nix flake lock && popd";
      nixos_upgrade = "pushd ~/nixconfig && nixos-rebuild --use-remote-sudo switch --verbose --flake .# && popd && nixos_diff";
      nixos_diff = "nvd diff $(ls -dv /nix/var/nix/profiles/system-*-link | tail -2)";
      nixos_gc = "sudo nix-collect-garbage -d && nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";

      # Always enable color for grep
      grep = "grep --color=auto";
    };

    initExtra = "eval $(thefuck --alias)";

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "jonathan";
    };
  };

}
