## Nano Laptop Specs

Lenovo Thinkpad Carbon X Nano (Gen 1)

- Intel i7-1160G7 - 8 cores @ 4.4 GHz
- 512 Gb SSD
- 16 Gb RAM

I use this laptop mainly for travel and to edit photos (while connected to an external monitor). One of the key requirements is Adobe Lightroom as I have yet to find a suitable Linux alternative (sadly).

Therefore, I'm dual booting this laptop with Windows 11 and NixOS. However, there's an issue with Windows 11 that causes it to create a small 100MB EFI partition.

The work around is to install Windows first, and during the installation process [expand the EFI partition](https://www.ctrl.blog/entry/how-to-esp-windows-setup.html). Failure to do this causes updates in NixOS to fail as there isn't enough space for updated kernels.
