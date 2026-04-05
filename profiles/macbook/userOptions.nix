{pkgs, ...}: {
  environment.systemPackages = with pkgs; [

  ];
   NixOS-Sec-Toolbox.enable = true;

    # NAS smb share  
  NASMount.enable = true;
  fingerprint.enable = true;
  services.nohang.enable = true;

}
