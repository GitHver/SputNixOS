{ pkgs
# , patt
, hostname
, ...
}:

let
  # inherit (patt) system-path;
  home-path = "~/.config/home-manager";
in {

  #====<< Home-manager install script >>=======================================>
  environment.shellAliases = {
    nix-perms = /*bash*/''
      sudo chown -R $USER /etc/nixos
      chgrp -R wheel /etc/nixos
      chmod -R g+w /etc/nixos
      cd /etc/nixos
      git init
      git add .
      git commit -m 'initial commit'
    '';
    home-get = /*bash*/''
      git clone https://github.com/GitHver/nixisotemphome.git ${home-path}
      rm -rf ${home-path}/.git
      cd ${home-path}
      $EDITOR flake.nix
    '';
    home-install = /*bash*/''
      nix shell nixpkgs#home-manager --command home-manager switch --flake ${home-path}
      git init
      git add .
      git commit -m 'initial commit'
    '';
    # Incase you already have a home configuration
    home-init = /*bash*/''
      nix shell nixpkgs#home-manager --command home-manager switch --flake ${home-path}
    '';
  };

}
