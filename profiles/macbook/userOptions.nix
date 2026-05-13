{
  config,
  pkgs,
  ...
}: {
  nix.settings = {
    # Large local builds such as linux-asahi can exhaust temporary sandbox
    # space on this machine when they fan out too aggressively.
    #   max-jobs = 2;
    #cores = 4;
  };

  environment.systemPackages = with pkgs; [

  ];


  machineProfiles = {
    allowUnsupported.enable = true;
    security.enable = false;
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

  programs.qylock = {
    enable = true;
    theme = "nier-automata"; # optional, this is the default
  };

}
