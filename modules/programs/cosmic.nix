{ pkgs
, lib
, config
, ...
}:

let
  inherit (lib) mkOption mkEnableOption mkIf;
  inherit (lib.types) bool;
  cfg = config.services.cosmic;
in {

  options.services.cosmic = {
    enable = mkEnableOption ''
      The COSMIC desktop environment
    '';
    greeter.enable = mkEnableOption ''
      The COSMIC display manager
    '';
    useXwayland = mkOption {
      type = bool;
      default = true;
      description = ''
        XWayland in the COSMIC compositor
      '';
    };
    useGnomeUtils = mkOption {
      type = bool;
      default = true;
      description = ''
        GNOME utils to fill in uses not yet covered by COSMIC
      '';
    };
  };

  config = {
    services = {
      desktopManager.cosmic.enable = cfg.enable;
      desktopManager.cosmic.xwayland.enable = cfg.useXwayland;
      displayManager.cosmic-greeter.enable = cfg.greeter.enable;
    };
    environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = mkIf cfg.enable 1;
    # This here is for default applications missing from COSMIC.
    environment.systemPackages = mkIf cfg.useGnomeUtils (with pkgs; [
      #==<< System management >>=========>
      gnome-disk-utility  # Disk formatter
      gnome-logs          # System logs
      file-roller         # File extractor
      #==<< Gnome extra >>===============>
      loupe               # Image viewer
      gnome-calculator    # Calculator
    ]);
  };

}
