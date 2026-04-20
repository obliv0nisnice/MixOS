{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkOption types;
in
{
  options.machineProfiles = {
    allowUnsupported.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Allow unsupported packages on Apple Silicon.";
    };

    security.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable the pentesting/security toolbox profile.";
    };

    virtualization.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable virtualization and container tooling.";
    };

    vpn.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable VPN-related services and packages.";
    };

    x86Emulation.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable x86_64 binfmt emulation on Apple Silicon.";
    };

    office.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable office/productivity desktop packages.";
    };

    comms.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable communication apps for the desktop profile.";
    };

    desktopIntegration.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable desktop integration helpers such as GVFS and applets.";
    };

    remoteAccess.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable remote access services such as OpenSSH.";
    };

    networkDiscovery.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable mDNS/zeroconf network discovery.";
    };

    usbImaging.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable USB printer/scanner helper services.";
    };

    batteryPerformance.enable = mkEnableOption "a lighter Hyprland profile for battery/performance testing";
  };
}
