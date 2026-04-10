# Tools for informtion gathering

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cloudbrute
    enumerepo
    holehe
    metabigor
    sn0int
    socialscan
    urlhunter
  ];
}
