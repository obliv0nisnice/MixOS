{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [

  ];

  machineProfiles = {
    allowUnsupported.enable = true;
    security.enable = true;
    virtualization.enable = true;
    vpn.enable = true;
    x86Emulation.enable = true;
    office.enable = true;
    comms.enable = true;
    desktopIntegration.enable = true;
    remoteAccess.enable = true;
    networkDiscovery.enable = true;
    usbImaging.enable = true;
    batteryPerformance.enable = false; # TODO(test): set to true to try the lighter Hyprland profile
  };
  NixOS-Sec-Toolbox.enable = config.machineProfiles.security.enable;

  # NAS smb share
  NASMount.enable = true;
  fingerprint.enable = true;
  services.nohang.enable = true;

}
