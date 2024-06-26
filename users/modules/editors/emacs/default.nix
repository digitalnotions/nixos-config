#
# Personal Emacs configuration
#

{ config, pkgs, lib, ... }:

{
  services.emacs = {
    enable = true;
    #    package = pkgs.emacs-git;
    package = pkgs.emacs;
  };
  
  programs.emacs = {
    enable = true;
    #    package = pkgs.emacs-git;
    package = pkgs.emacs;
  };

  home = {
    sessionVariables = {
      EDITOR = "emacsclient -t";
      VISUAL = "emacsclient -c";
    };
  };

  home.activation = {
    emacsActivation = lib.hm.dag.entryAfter ["writeBoundary"] ''
      CONFIG="$HOME/.emacs.d"

      if [ ! -d "$CONFIG" ]; then
        git clone git@github.com:digitalnotions/emacs.d.git $CONFIG
      fi
    '';
  };

}
