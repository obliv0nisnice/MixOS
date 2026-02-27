# Password and hashing tools

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    authoscope
    bruteforce-luks
    conpass
    crunch
    h8mail
    hashcat
    hashcat-utils
    hashdeep
    john
    legba
    nasty
    nth
    thc-hydra
    truecrack
    hashid
  ];
}
