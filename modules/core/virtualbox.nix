{ config, pkgs, ... }:

{
  virtualisation.virtualbox.host.enable = true;

  users.groups.vboxusers.members = [ "oblivion" ];

  # Nur aktivieren, wenn du das Oracle Extension Pack brauchst
  # z. B. für USB 2.0 / 3.0 Support
  # nixpkgs.config.allowUnfree = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;
}
