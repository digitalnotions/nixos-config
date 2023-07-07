#
# Personal Emacs configuration
#

{ config, pkgs, ... }:

{
  services.emacs = {
    enable = true;
    package = pkgs.emacs-git;
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-git;
  };

  home = {
    sessionVariables = {
#      EDITOR = "${pkgs.emacs-git}/bin/emacsclient -t";
#      VISUAL = "${pkgs.emacs-git}/bin/emacsclient -c";
      EDITOR = "emacsclient -t";
      VISUAL = "emacsclient -c";

    };
    # TODO: MOVE EMACS CONFIG TO SEPARATE GIT REPO
    file.".emacs.d" = {
      source = ./.emacs.d;
      recursive = true;
    };
  };
}
