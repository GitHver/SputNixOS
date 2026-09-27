{ lib
, ...
}:

let
  inherit (builtins) attrNames readDir;
in
  path: attrNames (readDir path)
