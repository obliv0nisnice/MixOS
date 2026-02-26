{pkgs, ...}:
  {

  programs = {
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    virt-manager.enable = true;
    mtr.enable = true;
    
    steam = {
      enable = false;
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true; 
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

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
    lm_sensors
    lolcat
    lshw
    lxqt.lxqt-policykit
    meson
    mpv
    ncdu
    ninja
    nixfmt
    pavucontrol
    pciutils
    picard
    pkg-config
    playerctl
    ripgrep
    socat
    unrar
    unzip
    usbutils
    v4l-utils
    virt-viewer
    wget
    ytmdl
    jetbrains.rider
    efibootmgr
    floorp-bin
    thunderbird
    liquidctl
    vesktop
    teams-for-linux
    sysstat
    vulkan-tools
    nodejs
    docker-client
    git-lfs
    neovim
    libdrm
    python3
    texliveTeTeX
    eza
    zip


    #RemoteConnection
    remmina
    openvpn
    wireshark
    

  # Pentesting stuff
    #wireshark
    #freerdp
    #netexec
    #evil-winrm
    #pywhisker
    #nmap
    #samba
    #smbmap
    #sqlcmd
    #python313Packages.impacket
    #responder
    #crowbar
    #rdesktop
    #fierce
    #dig
    smtp-user-enum

    
  ];
}
