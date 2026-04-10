{
  pkgs,
  username,
  host,
  ...
}: let
  inherit (import ../../hosts/${host}/variables.nix) keyboardLayout;
in {

    zramSwap.enable = true;
  # Services to start
  services = {
    power-profiles-daemon.enable = true;
    libinput.enable = true;
    fstrim.enable = true;
    gvfs.enable = true;
    openssh.enable = true;
    blueman.enable = true;

    greetd = {
      enable = true;
      settings = {
        default_session = {
          user = username;
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd start-hyprland"; # start Hyprland with a TUI login manager
        };
      };
    };
    gnome.gnome-keyring.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    ipp-usb.enable = true;
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
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };
}
