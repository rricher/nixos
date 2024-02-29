{
  description = "Basic flake config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  # outputs = { self, nixpkgs, ... }:
  outputs = { self, nixpkgs, home-manager, ... }:

    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";

      # configure pkgs
      pkgs = import nixpkgs {
        system = system;
        config = { allowUnfree = true;
                 allowUnfreePredicate = (_: true); };
      };

    in {
      nixosConfigurations = {
        desktop = lib.nixosSystem {
          inherit system;
          modules = [ ./profiles/desktop/configuration.nix ];
        };
        laptop = lib.nixosSystem {
          inherit system;
          modules = [ ./profiles/laptop/configuration.nix ];
        };
      };
      homeConfigurations = {
        "ryan@desktop" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./profiles/desktop/home.nix ];
        };
        "ryan@laptop" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./profiles/laptop/home.nix ];
        };
      };
    };
}
