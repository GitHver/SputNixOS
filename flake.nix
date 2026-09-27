{ ############################ Initial scope ###################################

  # Replace this with a description of what your flake does
  description = ''
    # The SputNix flake!

    The Purpose this flake is to be a starting template for beginners to use
    in order to get familiar with the Nix ecosystem. It is not a complete
    framework for using your system like a distribution, but is designed in
    a way for you to be easily able to modify by taking a fairly unopinionated
    stance on structuring.
  '';

  inputs = {
    #====<< Core Nixpkgs >>====================================================>
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #====<< Other >>===========================================================>
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # nixos-hardware.inputs.nixpkgs.follows = "nixpkgs";
    sputnix-extras.url = "github:GitHver/nixisoextras";
    sputnix-extras.inputs.nixpkgs.follows = "nixpkgs";
  };

  #====<< Outputs Field >>=====================================================>
  outputs = { self, nixpkgs, ... } @ inputs: let
    #====<< Required variables >>======>
    lib = nixpkgs.lib;
    alib = inputs.sputnix-extras.lib;
    #====<< Used functions >>==========>
    inherit (lib) nixosSystem genAttrs;
    inherit (alib) namesOfDirsIn attrsForEach;
    inherit (lib.lists) flatten;
    inherit (lib.filesystem) listFilesRecursive;
    #====<< Host information >>========>
    # This is only for the formatter, as it is not tied to an active system.
    genForAllSystems = (funct: genAttrs supportedSystems funct);
    supportedSystems = [
      "x86_64-linux"
      "x86_64-darwin"
      "i686-linux"
      "aarch64-linux"
      "aarch64-darwin"
    ];
  in {

    #====<< Nix Code Formatter >>==============================================>
    # This defines the formatter that is used when you run `nix fmt`. Since this
    # calls the formatters package, you'll need to define which architecture
    # package is used so different computers can fetch the right package.
    formatter = genForAllSystems (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in pkgs.nixpkgs-fmt
      or pkgs.nixfmt-rfc-style
      or pkgs.alejandra
    );

    #====<< NixOS Configurations >>============================================>
    # Here are all your different configurations. The function below takes a
    # list of all the hostnames for your hosts (determined by the names of the
    # directories in the `/hosts` directory) and creates an attribute set for
    # each host in the list.
    nixosConfigurations = attrsForEach (namesOfDirsIn ./hosts) (host: {
      "${host}" = nixosSystem {
        specialArgs = { inherit inputs lib alib host; };
        modules = flatten [
          ./hosts/${host}
          self.nixosModules.full
          { nixpkgs.overlays = self.overlays.inputOverlays; }
        ];
      };
    });

    #====<< NixOS Modules >>===================================================>
    # This creates an attributeset where the default attribute is a list of
    # all paths to modules. This can then be referenced with the `self`
    # attribute to give you access to all your modules anwhere.
    nixosModules = rec {
      default = { imports = listFilesRecursive ./modules; };
      full = [ default ] ++ inputModules;
      inputModules = (with inputs; [
        disko.nixosModules.default
        # other.nixosModules.default
      ]);
    };

    #====<< Overlays >>========================================================>
    # Overlays are perhaps the most powerful feature Nix has. You can use them
    # to overlay overrides to existing packages in the with custom options. This
    # alloes you to apply your own patches or build flags with out needing to
    # maintain a fork of nixpkgs or adding a third party repository.
    overlays = {
      inputOverlays = (with inputs; [
        sputnix-extras.overlays.default
      ]);
      # someOtherOverlay = overlay;
    };

  }; ############### The end of the `outputs` scope ############################

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      # "https://cosmic.cachix.org/"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      # "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
    ];
  };

} ################## End of the inital scope ###################################
