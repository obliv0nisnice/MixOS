{
  pkgs,
  config,
  lib,
  ...
}: let
  minegrubTheme = pkgs.stdenv.mkDerivation {
    pname = "minegrub-world-sel-theme";
    version = "1.0";
    src = pkgs.fetchFromGitHub {
      owner = "Lxtharia";
      repo = "minegrub-world-sel-theme";
      rev = "main";
      hash = "sha256-gBlP4aQQ0f3L6S1gWbidbflnp0p5hsJ8qmbyArZ8LO4=";
    };

    unpackPhase = ":";
    installPhase = ''
      mkdir -p $out/grub/theme
      cp -r $src/minegrub-world-selection/* $out/grub/theme
    '';
  };
in {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = ["v4l2loopback"];
    extraModulePackages = [config.boot.kernelPackages.v4l2loopback];
    kernel.sysctl = {"vm.max_map_count" = 2147483642;};

    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev"; # required for EFI systems
        useOSProber = true;

        # Theme aus Nix Store
        theme = lib.mkForce "${minegrubTheme}/grub/theme";

        # Minegrub Theme Integration
        minegrub-world-sel = {
          enable = true;
          customIcons = [
            {
              name = "nixos";
              lineTop = "NixOS (23/11/2023, 23:03)";
              lineBottom = "Survival Mode, No Cheats, Version: 23.11";
              imgName = "nixos";
              
            }
          ];
        };
      };

      efi.canTouchEfiVariables = true;
    };

    # AppImage Support
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };

    plymouth.enable = true;
  };
}
