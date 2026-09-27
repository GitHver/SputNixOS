{ pkgs
, lib
, config
, ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.hardware.amdgpu.rocmExtras;
in {

  options.hardware.amdgpu.rocmExtras.enable =
    mkEnableOption
    " extra RocM support"
  ;

  config = mkIf cfg.enable {
    #====<< AMD Drivers >>========================================================>
    nixpkgs.config.rocmSupport = true;
    hardware.graphics.extraPackages = with pkgs; [
      # rocmPackages.rocminfo
      # rocmPackages.rocm-smi
      # rocmPackages.clr
    ];
    # systemd.tmpfiles.rules = [
    #   "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    # ];
  };

}
