{ pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;

      enableCompletion = true;
      enableAutosuggestions = true;

      shellAliases = {
        ll = "ls -al";
        ec = "${pkgs.emacs29}/bin/emacsclient -n -c";
        nixos_update = "pushd ~/nixconfig && sudo nix flake update && sudo nix flake lock && popd";
        nixos_upgrade = "pushd ~/nixconfig && nixos-rebuild --use-remote-sudo switch --verbose --flake .# && popd && nixos_diff";
        nixos_diff = "nvd diff $(ls -dv /nix/var/nix/profiles/system-*-link | tail -2)";
        nixos_gc = "sudo nix-collect-garbage -d && nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";

        # Always enable color for grep
        grep = "grep --color=auto";
      };

      initExtra = ''
         eval $(thefuck --alias)
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
