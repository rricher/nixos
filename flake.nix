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
      # ---- SYSTEM SETTINGS ---- #
      systemSettings = {
        system = "x86_64-linux";
        timezone = "America/Los_Angeles"; # select timezone
        locale = "en_US.UTF-8"; # select locale
      };
      # ---- USER SETTINGS ---- #
      userSettings = {
        username = "ryan"; # username
        name = "Ryan"; # name/identifier
        email = "ryanricher@gmail.com"; # email (used for certain configurations)
        dotfilesDir = "~/.dotfiles"; # absolute path of the local repo
        wm = "gnome";
        browser = "firefox"; # Default browser; must select one from ./user/app/browser/
        term = "alacritty"; # Default terminal command;
        editor = "vim"; # Default editor;
      };

      lib = nixpkgs.lib;

      # configure pkgs
      pkgs = import nixpkgs {
        system = systemSettings.system;
        config = { allowUnfree = true;
                 allowUnfreePredicate = (_: true); };
      };

    in {
      nixosConfigurations = {
        desktop = lib.nixosSystem {
          system = systemSettings.system;
          modules = [ ./profiles/desktop/configuration.nix ];
          specialArgs = {
            inherit systemSettings;
            inherit userSettings;
          };
        };
        laptop = lib.nixosSystem {
          system = systemSettings.system;
          modules = [ ./profiles/laptop/configuration.nix ];
          specialArgs = {
            inherit systemSettings;
            inherit userSettings;
          };
        };
        
      };
      homeConfigurations = {
        "ryan@desktop" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./profiles/desktop/home.nix ];
          extraSpecialArgs = {
            inherit systemSettings;
            inherit userSettings;
          };
        };
        "ryan@laptop" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./profiles/laptop/home.nix ];
          extraSpecialArgs = {
            inherit systemSettings;
            inherit userSettings;
          };
        };
      };
    };
}
