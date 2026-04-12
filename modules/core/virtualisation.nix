{ config, pkgs, ... }:

{
  virtualisation.libvirtd.enable = true;

  programs.virt-manager.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.docker.enable = true;

  users.users.oblivion.extraGroups = [
    "libvirtd"
    "kvm"
    "docker"
  ];

  environment.systemPackages = with pkgs; [
    virt-manager
    qemu
    packer
    ansible
  ];
}
