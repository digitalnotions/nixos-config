{ pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;

      enableCompletion = true;
      enableAutosuggestions = true;

      shellAliases = {
        ll = "ls -al";

        # Emacs
        ec = "${pkgs.emacs}/bin/emacsclient -n -c";
        emacs_restart = "systemctl restart --user emacs && systemctl status --user emacs";

        # NixOS
        nixos_update = "pushd ~/nixconfig && sudo nix flake update && sudo nix flake lock && popd";
        nixos_upgrade = "pushd ~/nixconfig && nixos-rebuild --use-remote-sudo switch --verbose --flake .# && popd && nixos_diff";
        nixos_diff = "nvd diff $(ls -dv /nix/var/nix/profiles/system-*-link | tail -2)";
        nixos_gc = "sudo nix-collect-garbage -d && nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";


        # Always enable color for grep
        grep = "grep --color=auto";
      };

      initExtra = ''
         eval $(thefuck --alias)
         unsetopt autopushd
         neofetch
      '';

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "jonathan";
      };
    };
  };
}
