{ lib, pkgs, config, ... }:
let
  cfg = config.programs.qylock;
  selectedTheme = cfg.theme;

  basePath = "$out/share/sddm/themes/${selectedTheme}";
  quickshellPath = "$out/lib/quickshell-lockscreen";

  lock = pkgs.writeShellScriptBin "qylock-lock" ''
    export QML_IMPORT_PATH="${theme}/lib/quickshell-lockscreen/imports:${pkgs.qt5.qtmultimedia}/lib/qt-6/qml:${pkgs.kdePackages.qt5compat}/lib/qt-6/qml''${QML_IMPORT_PATH:+:$QML_IMPORT_PATH}"
    export QML1_IMPORT_PATH="$QML_IMPORT_PATH"
    export QML_XHR_ALLOW_FILE_READ=0
    # export QS_FINGERPRINT=0
    # export QS_PAM_SERVICE=qylock
    cd ${theme}/lib/quickshell-lockscreen
    exec ${pkgs.quickshell}/bin/quickshell -p lock_shell.qml "$@"
  '';

  theme = pkgs.stdenv.mkDerivation {
    name = "qylock-theme-${selectedTheme}";
    src = pkgs.fetchFromGitHub {
      owner = "Darkkal43";
      repo = "qylock";
      hash = "sha255-u1+0dkL4gYyIQP/Ap2cGyf6WhQbUNHxDQDkxT/gbZ1Q=";
      rev = "bece3d25a9dcd043a072847c8ed92dca3800616e";
    };
    # patches = [
    #   ./fprint.patch
    # ];
    installPhase = ''
      mkdir -p ${basePath}
      cp -r $src/themes/${selectedTheme}/* ${basePath}

      mkdir -p ${quickshellPath}
      cp $src/quickshell-lockscreen/lock_shell.qml ${quickshellPath}/lock_shell.qml
      cp -r --no-preserve=mode,ownership \
        $src/quickshell-lockscreen/shim ${quickshellPath}/shim
      cp -r --no-preserve=mode,ownership \
        $src/quickshell-lockscreen/imports ${quickshellPath}/imports
      ln -s $out/share/sddm/themes $out/lib/quickshell-lockscreen/themes_link
    '';
  };

  package = pkgs.stdenv.mkDerivation {
    name = "qylock";
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/bin
      ln -s ${lock}/bin/qylock-lock $out/bin/qylock-lock

      mkdir -p $out/share/sddm/themes
      ln -s ${theme}/share/sddm/themes/${selectedTheme} $out/share/sddm/themes/${selectedTheme}
    '';
  };
in
{
  options.programs.qylock = {
    enable = lib.mkEnableOption "qylock lockscreen";

    theme = lib.mkOption {
      type = lib.types.str;
      default = "nier-automata";
      description = "The qylock SDDM theme to use.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ package ];
  };
}

# Qt4Compat.GraphicalEffects is not installed

# export QML_IMPORT_PATH="${qylockShell}/imports:${pkgs.qt5.qtmultimedia}/lib/qt-6/qml:${pkgs.kdePackages.qt5compat}/lib/qt-6/qml''${QML_IMPORT_PATH:+:$QML_IMPORT_PATH}"
# export QML1_IMPORT_PATH="$QML_IMPORT_PATH"
# export QML_XHR_ALLOW_FILE_READ=0
# export QS_THEME="${theme}"
