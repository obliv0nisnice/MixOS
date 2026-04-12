{ ... }:

{
  zramSwap = {
    enable = true;
    algorithm = "zstd";    
    memoryPercent = 50;    
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 16384;           # 4 GB
  }];

  boot.kernel.sysctl = {
    "vm.swappiness"             = 180;   
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster"           = 0;    
  };
}
