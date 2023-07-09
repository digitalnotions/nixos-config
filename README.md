# Digital Notions NixOS Config

_I am by no means an expert. These config files work for my use case, but may not be correct or functional for anyone else. Also, I assume certain level of Linux abilities as I don't really explain everything in detail. Hopefully you find them helpful!_

## Installation on a new machine

Use whatever install media you like to get a new NixOS installation. I have found the graphical installer is fine as it allows me to LUKS encrypt my drive and partition however I want. It also allows me to install just about any desktop (or none at all). It doesn't really matter since once you pull down the configuration files, you end up re-creating whatever system you've defined.

Once in the new installation, you'll want to connect to the Internet and pull down the configuration files:

```
mkdir nixconfig

nix-env -iA nixos.git
git clone https://github.com/digitalnotions/nixos-config nixconfig
```

If this is a new installation (or you aren't me), you'll want to copy over the generated hardware configuration to the appropriate target.

For example, to install on a new host named `nano`:

```
cp /etc/nixos/hardware-config.nix nixconfig/hosts/nano
```

You'll also need to ensure that the everything is correct in the `nixconfig/hosts/xxx/default.nix` file depending on drive configuration and LUKS if you're using it. Referencing `/etc/nixos/configuration.nix` is helpful here.

Once you're ready to go, build the flake (targeting `nano` in this example):

```
sudo nixos-rebuild switch --flake .#nano
```

__Important note: If you're using a Git repo, you must commit changes to your files or else new files won't be picked up by the nixos-rebuild process.__

## Resources

Here are some resources that are particularly helpful:

* [NixOS Wiki](https://nixos.wiki/)
* [List of `nixpkgs` options](http://nmikhailov.github.io/nixpkgs/ch-options.html)
* [List of `home-manager` options](https://rycee.gitlab.io/home-manager/options.html)
