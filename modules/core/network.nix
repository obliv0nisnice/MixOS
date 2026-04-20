{
  config,
  lib,
  pkgs,
  host,
  options,
  ...
}:
{
  networking = {
    hostName = "${host}";
    extraHosts = "10.203.15.13 wiki.ls.lab
                  10.203.15.1 node-01.ls.lab";
    networkmanager.enable = true;
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
    firewall = {
      enable = true;
      allowedTCPPorts = lib.optionals config.machineProfiles.remoteAccess.enable [
        22
      ] ++ [
        80
        443
        59010
        59011
      ];
      allowedUDPPorts = [
        59010
        59011
      ] ++ lib.optionals config.machineProfiles.vpn.enable [
        51820
      ];
    };
  };

  environment.systemPackages =
    with pkgs;
    lib.optionals config.machineProfiles.desktopIntegration.enable [ networkmanagerapplet ];
}
