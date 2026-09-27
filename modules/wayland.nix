{ pkgs
, lib
, config
, ...
}:

let
  inherit (lib) mkOption mkIf types;
  name = "wayland-utils";
  cnfg = config.services.${name};
in {

  options.services.${name}.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf cnfg.enable {
    programs.xwayland.enable = true; # For running X11 applications
    environment.variables.NIXOS_OZONE_WL = "1";
    environment.systemPackages = with pkgs; [
      wl-clipboard
      wayland-utils
      xwayland-satellite

      cage
      libsecret
      gamescope

      brightnessctl
      # clightd
      # wl-gammactl
      # wl-gammarelay-rs
      wlr-randr
    ];
    # programs.light.brightnessKeys = {
    #   enable = true;
    #   step  = 5;
    # };
  };

}
