{ pkgs, host, options, ... }:
{
  networking = {
    hostName = "${host}";
    extraHosts = "10.129.201.127 int-ftp.inlanefreight.htb ";
    networkmanager.enable = true;
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        59010
        59011
      ];
      allowedUDPPorts = [
        59010
        59011
        51820
      ];
    };
  };

  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}
