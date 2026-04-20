# NixOS on Apple Silicon

Dieses Repository beschreibt ein modulares NixOS-Setup fuer ein Apple-Silicon-MacBook unter Asahi Linux.
Der aktuelle Host ist `macbook` auf `aarch64-linux` mit:

- `nixos-unstable`
- `nix-community/nixos-apple-silicon`
- `home-manager`
- `stylix`
- `nixvim`
- Hyprland als Wayland-Desktop

## Aufbau

Die Flake definiert einen Host:

- `macbook`

Die Konfiguration ist grob in drei Bereiche getrennt:

- `flake.nix`: Inputs und Host-Definition
- `modules/core`: systemweite NixOS-Module
- `modules/home`: Home-Manager-Module fuer den User
- `profiles/macbook`: host-spezifische Schalter und Defaults
- `hosts/macbook/variables.nix`: Host-Variablen wie Browser, Tastatur, Monitore

## Wie das System aktuell funktioniert

### Systemseite

Die Host-Konfiguration importiert:

- `hardware-configuration.nix`
- das Apple-Silicon-Support-Modul aus `nixos-apple-silicon`
- alle Core-Module aus `modules/core`
- das MacBook-Profil aus `profiles/macbook`

Aktiv sind unter anderem:

- `NetworkManager` mit Firewall-Regeln
- `greetd` + `tuigreet` als Login-Manager
- `pipewire` fuer Audio
- `power-profiles-daemon`
- `fstrim`
- `gnome-keyring`
- `nh` fuer Builds/Garbage-Collection
- `home-manager` fuer den User `oblivion`
- `stylix` fuer das Theme
- `zram` plus Swapfile
- optional `mullvad`, `Docker/libvirt`, `x86_64`-Binfmt und Security-Tooling ueber Profile

### Desktopseite

Im Home-Manager-Teil ist aktuell vor allem ein Hyprland-Desktop hinterlegt:

- Hyprland
- hypridle
- hyprlock
- hyprpaper
- pyprland
- waybar
- swaync
- rofi
- kitty
- nixvim
- stylix-Zielkonfiguration fuer Waybar/NVF

Hyprland startet u.a.:

- `waybar`
- `swaync`
- `nm-applet`
- `lxqt-policykit-agent`
- `pypr`
- `hyprpaper`

Der Look ist absichtlich nicht minimal: Blur, Schatten und Animationen sind standardmaessig aktiv.

## Profile

Die zentralen Schalter liegen in [profiles/macbook/userOptions.nix](./profiles/macbook/userOptions.nix) und werden als `machineProfiles.*` gesetzt.

Aktuell gibt es:

- `allowUnsupported.enable`: erlaubt unsupported Pakete auf Apple Silicon
- `security.enable`: aktiviert die `NixOS-Sec-Toolbox`
- `virtualization.enable`: aktiviert Docker/libvirt/virt-manager/QEMU + passende Gruppen
- `vpn.enable`: aktiviert Mullvad-bezogene Pakete/Ports/Service
- `x86Emulation.enable`: aktiviert `boot.binfmt.emulatedSystems = [ "x86_64-linux" ]`
- `office.enable`: aktiviert `libreoffice` und `anki`
- `comms.enable`: aktiviert `thunderbird`, `vesktop`, `teams-for-linux`
- `desktopIntegration.enable`: aktiviert Desktop-Helfer wie `gvfs` und `networkmanagerapplet`
- `remoteAccess.enable`: aktiviert `openssh` und Port `22`
- `networkDiscovery.enable`: aktiviert `avahi`
- `usbImaging.enable`: aktiviert `ipp-usb`
- `batteryPerformance.enable`: schaltet ein leichteres Hyprland-Profil

### Battery-/Performance-Profil

Wenn `machineProfiles.batteryPerformance.enable = true;` gesetzt ist, wird Hyprland sichtbar leichter konfiguriert:

- weniger Blur-Passes
- kleinere Blur-Size
- keine Fenster-Schatten
- kuerzere Animationen

Das Profil ist bewusst nur ein Testprofil und kein kompletter "low-spec mode". Das Look-and-feel bleibt erhalten, aber GPU/Compositor-Last sinkt etwas.

## Sonstige Schalter

Neben den Profilen gibt es noch einzelne Module, die separat aktiviert werden:

- `NASMount.enable = true;`
  bindet ein CIFS-Share unter `~/Documents/NAStalavista` ein
- `fingerprint.enable = true;`
  aktiviert `fprintd`
- `services.nohang.enable = true;`
  aktiviert NoHang

Hinweis: `programs.hyprlock.settings.auth.fingerprint.enabled = true;` ist ebenfalls gesetzt. Wenn Fingerprint auf dem Geraet praktisch nicht funktioniert, sollten beide Stellen gemeinsam deaktiviert werden.

## Wichtige Dateien

- [flake.nix](./flake.nix)
- [hardware-configuration.nix](./hardware-configuration.nix)
- [profiles/macbook/userOptions.nix](./profiles/macbook/userOptions.nix)
- [hosts/macbook/variables.nix](./hosts/macbook/variables.nix)
- [modules/core/default.nix](./modules/core/default.nix)
- [modules/core/profiles.nix](./modules/core/profiles.nix)
- [modules/core/packages.nix](./modules/core/packages.nix)
- [modules/core/services.nix](./modules/core/services.nix)
- [modules/core/user.nix](./modules/core/user.nix)
- [modules/home/hyprland/config.nix](./modules/home/hyprland/config.nix)

## Build / Switch

Direkt:

```bash
sudo nixos-rebuild switch --flake .#macbook --impure
```

Mit `nh`:

```bash
nh os switch --hostname macbook
```

Update:

```bash
nh os switch --hostname macbook --update
```

## Validierung

Zum reinen Evaluieren ohne Build:

```bash
nix eval --impure .#nixosConfigurations.macbook.config.system.build.toplevel.drvPath
```

## Aktueller Zustand

Die Konfiguration evaluiert aktuell erfolgreich.
Es gibt aber weiterhin bereits bestehende Warnings aus dem Stack:

- Home-Manager-Defaults fuer `gtk.gtk4.theme`
- Home-Manager-Defaults fuer `xdg.userDirs.setSessionVariables`
- Home-Manager-Defaults fuer `programs.git.signing.format`
- `nixvim`-Warnung wegen `settings` -> `config`
- Stylix-Warnung fuer `qt.style`

Diese Warnings stammen nicht aus dem Profil-Umbau selbst, sondern aus bereits vorhandenen Konfigurationsentscheidungen oder Upstream-Aenderungen.
