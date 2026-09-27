{ lib, config, ... }:

with lib;
let
  cnfg = config.nvidia;
in

{
  options.nvidia.enable = mkOption {
    type = types.bool;
    default = false;
    # description = "NVIDIA GPU Drivers";
  };

  config = mkIf cnfg.enable {

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = [ "nvidia" ];
    boot.kernelParams = [ "nvidia_drm.fbdev=1" ];

    hardware.nvidia = {

      package = config.boot.kernelPackages.nvidiaPackages.stable;
      open = false; # Currently alpha-quality/buggy, so false is currently the recommended setting.

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;

      # Modesetting is required.
      modesetting.enable = true;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
      # of just the bare essentials.
      powerManagement.enable = false;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;

    };
  };
}
