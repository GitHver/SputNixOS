{ pkgs }:

pkgs.mkShell {
  packages = (with pkgs; [
    hello
  ]);
  shellHook = /*bash*/''
    echo '
      You have now entered a Nix development shell!
      type `exit` to leave
    '
    exec hello
  '';
}
