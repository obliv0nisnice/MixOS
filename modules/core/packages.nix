{pkgs, ...}:
  {

  programs = {
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    virt-manager.enable = true;
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
nixpkgs.config.allowUnsupportedSystem = true;

  environment.systemPackages = with pkgs;[
    coreutils-full
    brightnessctl # For Screen Brightness Control
    cmatrix # Matrix Movie Effect In Terminal
    docker-compose # Allows Controlling Docker From A Single File
    file-roller # Archive Manager
    tuigreet # The Login Manager (Sometimes Referred To As Display Manager)
    thunar-archive-plugin
    thunar-volman
    hyprpicker
    imv
    inxi
    killall
    libnotify
    libvirt
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
    virt-viewer
    wget
    ytmdl
    efibootmgr
    floorp-bin
    thunderbird
    vesktop
    teams-for-linux
    sysstat
    nodejs
    docker-client
    git-lfs
    neovim
    libdrm
    python3
    eza
    zip
    rofimoji

    # unnecessary windows shit
    libreoffice

    #Cloud 
    terraform
    awscli2
    
    # AI coding tools
    claude-code

    #RemoteConnection
    remmina
    openvpn
    wireshark
    openconnect
    mullvad-vpn
    
    #RemoteScanning
    openscap

  # Pentesting stuff
    python313Packages.impacket
    file
    medusa
    smtp-user-enum

    # power Analyse
    powertop

    #learnstuff
    anki

    
    
  ];
}
