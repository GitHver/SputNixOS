{ lib
}:

let
  inherit (builtins) attrNames readDir;
  inherit (lib.attrsets) filterAttrs;
  onlyDirectories = (name: value: value == "directory");
  directorySetFrom = (path: filterAttrs onlyDirectories (readDir path));
in
  path:
    attrNames (directorySetFrom path)
