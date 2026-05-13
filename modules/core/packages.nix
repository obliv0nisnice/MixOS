{
  config,
  lib,
  pkgs,
  ...
}:
let
  unblobPatched = pkgs.unblob.overrideAttrs (old: {
    # These handlers currently report sandbox-specific failures in nixpkgs'
    # check environment, while the rest of the suite still passes.
    disabledTests = (old.disabledTests or []) ++ [
      "test_all_handlers[filesystem.romfs]"
      "test_all_handlers[filesystem.yaffs]"
    ];
  });
in {

  programs = {
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    virt-manager.enable = lib.mkDefault config.machineProfiles.virtualization.enable;
    mtr.enable = true;
    
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [];

    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = config.machineProfiles.allowUnsupported.enable;

  environment.systemPackages = with pkgs;[
    coreutils-full
    brightnessctl # For Screen Brightness Control
    cmatrix # Matrix Movie Effect In Terminal
    file-roller # Archive Manager
    tuigreet # The Login Manager (Sometimes Referred To As Display Manager)
    thunar-archive-plugin
    thunar-volman
    hyprpicker
    imv
    inxi
    killall
    libnotify
    lshw
    lxqt.lxqt-policykit
    meson
    mpv 
    ncdu
    ninja
    nixfmt
    pavucontrol
    pciutils
    pkg-config
    playerctl
    ripgrep
    socat
    unrar
    unzip
    usbutils
    wget
    ytmdl
    efibootmgr
    floorp-bin
    sysstat
    nodejs
    git-lfs
    neovim
    libdrm
    python3
    eza
    zip
    rofimoji

    # 3D
    unityhub

    heroic

    typst

    #file manager
    ranger
    yazi
    
    dotnet-sdk_8

    # Cloud
    terraform
    awscli2

    # AI coding tools
    claude-code
    codex
    

    # RemoteConnection
    remmina
    openvpn
    wireshark
    openconnect

    # RemoteScanning
    openscap

    # Pentesting stuff
    python313Packages.impacket
    file
    medusa
    smtp-user-enum
    gdb
    gcc
    gnumake
    pwntools
    boofuzz
    unblobPatched


    # power Analyse
    powertop

  ] ++ lib.optionals config.machineProfiles.virtualization.enable [
    docker-compose # Allows Controlling Docker From A Single File
    docker-client
    libvirt
    virt-viewer
  ] ++ lib.optionals config.machineProfiles.comms.enable [
    thunderbird
    vesktop
    teams-for-linux
  ] ++ lib.optionals config.machineProfiles.office.enable [
    libreoffice
    anki
  ] ++ lib.optionals config.machineProfiles.vpn.enable [
    mullvad-vpn
    netbird
  ];
}
