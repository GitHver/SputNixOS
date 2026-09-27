{ pkgs
, lib
, config
, ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.services.syncthing;
in {

  options.services.syncthing.openPorts = mkEnableOption ''
    open ports for syncthing to use in home-manager.
  '';

  config = mkIf cfg.openPorts {
    #====<< Network config >>====================================================>
    networking.firewall = {
      allowedTCPPorts = [ 22000 ];
      allowedUDPPorts = [ 21027 22000 ];
    };
  };

}
