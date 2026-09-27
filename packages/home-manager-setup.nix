{ pkgs }:

pkgs.writeShellApplication {
  name = "home-manager-setup";
  text = ./../programs/home-manager-setup;
}
