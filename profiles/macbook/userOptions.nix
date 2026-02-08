{pkgs, ...}: {
  environment.systemPackages = with pkgs; [

  ];
  # NixOS-Sec-Toolbox.enable = false;

    # NAS smb share  
    NASMount.enable = true;

}
