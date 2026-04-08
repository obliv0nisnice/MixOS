 {username, pkgs, ...}: {
   #TODO: Optimieren
    home.file.".config/hypr/hyprpaper.conf".source = pkgs.writeText "hyprpaper.conf" ''
 
    # Fallback for all monitors
    wallpaper {
      monitor = *
      path = /home/${username}/NixOS/wallpapers/Legend_of_Zelda.png
      fit_mode = cover
    }

    # MacBook internal Display
    wallpaper {
      monitor = eDP-1
      path = /home/${username}/NixOS/wallpapers/Legend_of_Zelda.png
      fit_mode = cover
    }

    # External monitors (Dock)
    wallpaper {
      monitor = DP-1
      path = /home/${username}/NixOS/wallpapers/Legend_of_Zelda.png
      fit_mode = cover
    }

    wallpaper {
      monitor = DP-2
      path = /home/${username}/NixOS/wallpapers/Legend_of_Zelda.png
      fit_mode = cover
    }

    wallpaper {
      monitor = HDMI-A-1
      path = /home/${username}/NixOS/wallpapers/Legend_of_Zelda.png
      fit_mode = cover
    }  '';}
