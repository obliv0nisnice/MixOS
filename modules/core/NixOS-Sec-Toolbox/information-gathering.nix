# Tools for informtion gathering

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cloudbrute
    enumerepo
    holehe
    maigret
    metabigor
    sn0int
    socialscan
    urlhunter
  ];
}
