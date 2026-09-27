{ pkgs
, lib
, config
, ...
}:

let
  inherit (lib) mkOption mkIf types;
  cnfg = config.bluetooth;
in {

  options.bluetooth.enable = mkOption {
    type = types.bool;
    default = false;
  };

  config = mkIf cnfg.enable {
    services.blueman.enable = true;
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.Policy.AutoEnable = "true";
      settings.General.Enable = "Source,Sink,Media,Socket";
    };
    environment.systemPackages = with pkgs; [
      bluez
      bluez-tools
      bluetuith
      #blueman
    ];
  };

}
