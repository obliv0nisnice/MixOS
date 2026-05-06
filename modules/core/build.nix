
{  config, pkgs, lib, ... }:
{

  nix.extraOptions = ''
  build-dir = /home/.nix-build
'';
}
