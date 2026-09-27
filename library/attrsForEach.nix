{ lib
, ...
}:

let
  inherit (lib.lists) forEach;
  attrsFromList = import ./attrsFromList.nix { inherit lib; };
in
  list: func:
    attrsFromList (forEach list func)
