{ pkgs }:

pkgs.writeShellApplication {
  name = "nix-iso-setup";
  text = ./../programs/nix-iso-setup;
}
