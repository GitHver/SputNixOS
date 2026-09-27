{ pkgs
, lib
, alib
, config
, ...
}:

let
  inherit (builtins) attrNames concatMap head;
  inherit (lib) mkOption;
  inherit (lib.types) attrs;
  inherit (alib) attrsFromList;
  cfg = config.users.userGroups;
in {

  options = {
    users.userGroups = mkOption {
      type = attrs;
      default = {};
    };
  };

  config = {
    users.users =
      attrNames cfg
      # results in:
      # [
      #   "guests"
      #   "admins"
      #   ... # Other usersGroups you create
      # ]
      |> concatMap (userGroup: cfg.${userGroup}.users
      # results in:
      # [
      #   [ "guest1" "Guest 1" ]
      #   [ "guest2" "Guest 2" ]
      #   ...
      # ]
        |> map (user: {
          ${(head user)} = (removeAttrs cfg.${userGroup} ["users"])
          // { name = (head user); description = (lib.lists.last user); };
        })
      # results in:
      # [
      #   [
      #     { guest1 = { guestsettings }; }
      #     { guest2 = { guestsettings }; }
      #   ]
      #   [...] # more after each map of `userGroups`
      # ]
      )
      # results in:
      # [
      #   { guest1 = { guestsettings }; }
      #   { guest2 = { guestsettings }; }
      #   { admin1 = { adminsettings }; }
      #   ...
      # ]
      # because `concatMap` already removes the nested lists.
      |> attrsFromList
      # results in:
      # {
      #   admin1 = { adminsettings };
      #   guest1 = { guestsettings };
      #   guest2 = { guestsettings };
      #   ...
      # }
    ;

  };

}
