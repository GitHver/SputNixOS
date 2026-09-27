{ pkgs
, lib
, config
, ...
}:

let
  inherit (lib) mkOption mkIf types;
  cfg = config.users.makeUsers;
in {

  # options.users.makeUsers = {
    
    
  # };

  # config.users = {
  #   users = 
  # };

}
