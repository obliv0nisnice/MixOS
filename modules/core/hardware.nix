{ pkgs, ... }:
{
  hardware = {
    graphics.enable = true;
    enableRedistributableFirmware = true;
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
  };
  time.hardwareClockInLocalTime = false;
  }
