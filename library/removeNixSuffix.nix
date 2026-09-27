{ lib
}:

let
  inherit (lib.strings) removeSuffix;
in
  file:
    removeSuffix ".nix" file
