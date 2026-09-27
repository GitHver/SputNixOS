{ lib
, ...
}:

let
  inherit (builtins) foldl';
in
  list:
    foldl' (a: b: a // b) { } list
