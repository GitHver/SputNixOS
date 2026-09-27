{ lib
, ...
}:

let
  inherit (builtins) elem;
  inherit (lib) getName;
in {

  # Here you can put unfree packages you absolutely trust to allow them to be
  # installed. Software that cannot access the internet are good examples.
  nixpkgs.config.allowUnfreePredicate = (pkg:
    elem (getName pkg) [
      # Add additional package names here
      # "nvidia-x11"
      # "nvidia-settings"
      # "nvidia-persistenced"
      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
      "minecraft-server"
    ]
  );

}
