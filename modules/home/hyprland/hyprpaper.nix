 {username, pkgs, ...}: {
    home.file.".config/hypr/hyprpaper.conf".source = pkgs.writeText "hyprpaper.conf" ''
 
    wallpaper {
      monitor = DP-2
      path = /home/${username}/NixOS/wallpapers/Legend_of_Zelda.png
      fit_mode = cover
    }

    wallpaper {
      monitor = DP-1
      path = /home/${username}/NixOS/wallpapers/peakpx(3).jpg 
      fit_mode = cover
    }

    wallpaper {
      monitor = HDMI-A-1
      path = /home/${username}/NixOS/wallpapers/Legend_of_Zelda.png
      fit_mode = cover
    }
  '';}
