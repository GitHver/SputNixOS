{ pkgs }:

pkgs.writeShellApplication {
  name = "nix";
  text = ./../programs/nix-iso-setup;
}
  
