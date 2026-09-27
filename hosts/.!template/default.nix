{ pkgs, config, host, inputs, ... }: {

  #====<< Imported files >>====================================================>
  # Imports all the files in this host's directory, as some not all might have
  # the same files in the structure.
  imports = [
    ./user-rules.nix
    ./disko.nix
    ./hardware-configuration.nix
  ];

  #====<< Presets >>===========================================================>
  # Presets to follow. made for shared changes across pcs.
  presets.pcConfiguration.enable = true;

  #====<< Privileged programs >>=======================================>
  # Some programs require special privileges in order to function
  # properly, where Home Manager can't provide.
  nixpkgs.config.allowUnfree = false;
  programs = {
    qemuvm.enable = false;     # The QEMU virtual machine.
    steam.full.enable = true;  # Steam module with all permissions.
    # steam.openFirewall = true;
  };
  environment.systemPackages = (with pkgs; [
    # some packages
  ]);
  services = {
    # i2p.enable = true;
  };

  #====<< Network config >>====================================================>
  networking = {
    hostName = host;          # The name of your computer on the network.
    networkmanager.enable = true; # Networkmanager handles wifi and ethernet.
    firewall = {                # If you're having trouble with connection
      enable = true;            # permissions, you can disable the firewall
      allowedTCPPorts = [ ];    # or open some ports here,
      allowedUDPPorts = [ ];    # or here.
    };
  };

  #====<< Hardware Options >>==================================================>
  hardware = {
    # Allow for Nix to download new firmware. `enableRedistributableFirmware` is
    # only for firmware with a free license. Some bluetooth device drivers may
    # need non free firmware to function properly.
    enableRedistributableFirmware = true;
    enableAllFirmware = false;
    # Bluetooth, already enalbed by cosmic.
    bluetooth.enable = true;
    # Needed to enable hardware acceleration. enabled by other modules, so is
    # not needed in most configurations.
    graphics.enable = true;
    graphics.enable32Bit = true;
    # AMD GPU tuning. Drivers are enabled by default with `graphics.enable`.
    # amdgpu = {
    #   initrd.enable = true;
    #   opencl.enable = true;
    #   rocmExtras.enable = true;
    # };
    # NVIDIA GPU Drivers.
    # nvidia = {
    #   enabled = true;
    #   open = true;
    #   package = with config.boot.kernelPackages.nvidiaPackages; stable;
    #   modesetting.enable = true;
    #   nvidiaSettings = false;
    # };
  };

  #====<< Linux kernel options >>==============================================>
  # By default the kernel is updated to the latest version deemed stable. Here
  # it is set to the latest release. Uncomment the line below to go use the
  # stable kernel. You can also select a specific version of the kernel like:
  # `pkgs.linuxKernel.kernels.linux_6_1`. Default is `pkgs.linuxPackages`.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [];
  boot.kernelModules = [];

  #====<< Swap options >>======================================================>
  # ZRAM creates a block device in you RAM that works as swap. It compresses all
  # the contents moved there, effectively increasing your RAM size at the cost
  # of some processing power. https://nixos.wiki/wiki/Swap#Enable_zram_swap
  zramSwap = {
    enable = true;
    memoryPercent = 30;
    algorithm = "zstd";
  };

  #====<< Bootloader >>========================================================>
  # Be VERY careful when changing this, Nix is unbreakable in everything except
  # in one thing: messing with the boot-loader. You don't want to leave your
  # system in an unbootable state, so make sure you know what you are doing when
  # rebuilding any changes here. Best to first use a virtual machine with:
  # $ sudo nixos-rebuild build-wm-with-bootloader
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 5;
  # The systemd bootloader. GRUB Might be needed for legacy BIOS system.
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 20;
    consoleMode = "1";
    memtest86.enable = false;
    netbootxyz.enable = false;
    editor = false;
  };
  # Boot font style and size.
  console = {
    earlySetup = true;
    font = 
    let fontsize = "16";
    in "ter-i${fontsize}b";
    packages = [ pkgs.terminus_font ];
  };

}
