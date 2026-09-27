{ lib
, config
, ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  cfg =  config.programs.steam;
in {

  options = {
    programs.steam = {
      full.enable = mkEnableOption ''
        Steam client with all permissions
      '';
      openFirewall = mkEnableOption ''
        The opening of ports to allow steam to create servers for remoteplay and other dedicated servers
      '';
      };
  };

  config = {
    programs.steam = mkIf cfg.full.enable {
      enable = true;
      # Open ports in the firewall for Steam Remoteplay.
      remotePlay.openFirewall = true;
      # Open ports in the firewall for Steam server.
      dedicatedServer.openFirewall = true;
      # Opens ports to allow file (game) transfers on your local network.
      localNetworkGameTransfers.openFirewall = true;
      # Valve's micro compositor. Runs inside your primary compositor.
      # gamescopeSession.enable = true;
    };
    networking.firewall = mkIf cfg.openFirewall {
        allowedTCPPorts = [ 27015 27036 27040 ]; # SRCDS Rcon port
        allowedUDPPorts = [ 27015 27036 ]; # Gameplay traffic
        allowedUDPPortRanges = [ { from = 27031; to = 27035; } ];
    };
  };

}

