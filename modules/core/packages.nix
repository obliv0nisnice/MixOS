{pkgs, ...}:
  {

  programs = {
    firefox.enable = false; # Firefox is not installed by defualt
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

  environment.systemPackages = with pkgs;[
    # android-tools
    #amfora # Fancy Terminal Browser For Gemini Protocol
    #appimage-run # Needed For AppImage Support
    brightnessctl # For Screen Brightness Control
    cmatrix # Matrix Movie Effect In Terminal
    docker-compose # Allows Controlling Docker From A Single File
    #duf # Utility For Viewing Disk Usage In Terminal
    #eza # Beautiful ls Replacement
    #ffmpeg # Terminal Video / Audio Editing
    file-roller # Archive Manager
    #gedit # Simple Graphical Text Editor
    #gimp # Great Photo Editor
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
    ollama-cuda
    #nvidia-system-monitor-qt
    efibootmgr
    floorp-bin
    #spotify
    thunderbird
    liquidctl
    vesktop
    teams-for-linux
    flatpak
    sysstat
    vulkan-tools
    #heroic
    nodejs
    docker-client
    pdfstudioviewer
    blender
    git-lfs
    neovim

    #RemoteConnection
    remmina
    openvpn3

    #NAS
    
  ];
}
