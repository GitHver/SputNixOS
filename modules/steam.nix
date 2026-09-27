{ lib
, config
, ...
}:

let
  inherit (lib) mkOption mkIf types;
  name = "steam-full";
  cfg = config.programs.${name};
in {

  options.programs.${name}.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Steam client with all permissions";
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      # Open ports in the firewall for Steam Remotepla.
      remotePlay.openFirewall = true;
      # Open ports in the firewall for Steam server.
      dedicatedServer.openFirewall = true;
      # Opens ports to allow file (game) transfers on your local network.
      localNetworkGameTransfers.openFirewall = true;
      # Valve's micro compositor. Runs inside your primary compositor.
      gamescopeSession.enable = true;
    };
  };

}

