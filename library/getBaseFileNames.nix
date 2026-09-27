{ lib
, ...
}:

let
  inherit (builtins) attrNames readDir;
  removeNixSuffix = import ./removeNixSuffix.nix { inherit lib; };
in
  dir:
    map removeNixSuffix (attrNames (readDir dir))
