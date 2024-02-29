{
  description = "My first flake!";

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
  let
    # ---- SYSTEM SETTINGS ---- #
    systemSettings = {
      system = "x86_64-linux";
      hostname = "ryanpc"; # hostname
      profile = "work"; # select a profile defined from my profiles directory
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
    };

    # configure pkgs
    pkgs = import nixpkgs {
      system = system;
      config = { 
        allowUnfree = true;
        allowUnfreePredicate = (_: true); 
      };
    };

    lib = nixpkgs.lib;

  in {
    homeConfigurations = {
      ryan = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ (./. + "/profiles"+("/"+systemSettings.profile)+"/home.nix") ];
        extraSpecialArgs = {
          inherit systemSettings;
          inherit userSettings;
        };
      };
    };
    nixosConfigurations = {
      ryanpc = lib.nixosSystem {
        system = systemSettings.system;
        modules = [ (./. + "/profiles" + ("/" + systemSettings.profile) + "./configuration.nix") ];
      };
      specialArgs = {
        inherit systemSettings;
        inherit userSettings;
      };
    };
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
}
