{
  config,
  lib,
  pkgs,
  username,
  host,
  ...
}: let
  inherit (import ../../hosts/${host}/variables.nix) keyboardLayout;
in {

  # Services to start
  services = {
    power-profiles-daemon.enable = true;
    libinput.enable = true;
    fstrim.enable = true;
    gvfs.enable = config.machineProfiles.desktopIntegration.enable;
    openssh.enable = config.machineProfiles.remoteAccess.enable;
    blueman.enable = true;

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm; # Qt6 SDDM — required for qylock themes
      extraPackages = with pkgs.kdePackages; [
        qt5compat    # provides Qt5Compat.GraphicalEffects used by qylock themes
        qtmultimedia # for video backgrounds
        qtsvg
      ];
    };

    displayManager.defaultSession = "hyprland";

    gnome.gnome-keyring.enable = true;
    avahi = {
      enable = config.machineProfiles.networkDiscovery.enable;
      nssmdns4 = true;
      openFirewall = true;
    };
    ipp-usb.enable = config.machineProfiles.usbImaging.enable;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };

  # Security / Polkit
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';
  programs.hyprland.enable = true;

  security.pam.services.qylock = {
    text = ''
      auth include login
    '';
  };

  services.xserver.xkb = {
    layout = keyboardLayout;
    variant = "";
  };
}
