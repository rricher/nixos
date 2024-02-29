{
  description = "Flake of LibrePhoenix";

  outputs = inputs@{ self, nixpkgs, home-manager, stylix, hyprland-plugins, ... }:
  let
    # ---- SYSTEM SETTINGS ---- #
    systemSettings = {
      system = "x86_64-linux"; # system arch
      hostname = "ryanpc"; # hostname
      profile = "work"; # select a profile defined from my profiles directory
      timezone = "America/Los_Angeles"; # select timezone
      locale = "en_US.UTF-8"; # select locale
    };

    # ----- USER SETTINGS ----- #
    userSettings = rec {
      username = "ryan"; # username
      name = "Ryan"; # name/identifier
      email = "ryanricher@gmail.com"; # email (used for certain configurations)
      dotfilesDir = "~/.dotfiles"; # absolute path of the local repo
      theme = "uwunicorn-yt"; # selcted theme from my themes directory (./themes/)
      wm = "hyprland"; # Selected window manager or desktop environment; must select one in both ./user/wm/ and ./system/wm/
      # window manager type (hyprland or x11) translator
      wmType = if (wm == "hyprland") then "wayland" else "x11";
      browser = "qutebrowser"; # Default browser; must select one from ./user/app/browser/
      defaultRoamDir = "Personal.p"; # Default org roam directory relative to ~/Org
      term = "alacritty"; # Default terminal command;
      font = "Intel One Mono"; # Selected font
      fontPkg = pkgs.intel-one-mono; # Font package
      editor = "vim"; # Default editor;
      # editor spawning translator
      # generates a command that can be used to spawn editor inside a gui
      # EDITOR and TERM session variables must be set in home.nix or other module
      # I set the session variable SPAWNEDITOR to this in my home.nix for convenience
      spawnEditor = if (editor == "emacsclient") then "emacsclient -c -a 'emacs'"
                    else (if ((editor == "vim") || (editor == "nvim") || (editor == "nano")) then "exec " + term + " -e " + editor else editor);
    };

    # configure pkgs
    pkgs = import nixpkgs {
        system = system;
        config = { allowUnfree = true;
                 allowUnfreePredicate = (_: true); };
      };lays = [ rust-overlay.overlays.default ];
    };

    # configure lib
    lib = nixpkgs.lib;

    # Systems that can run tests:
     supportedSystems = [
       "x86_64-linux"
     ];

    # Function to generate a set based on supported systems:
    forAllSystems = inputs.nixpkgs.lib.genAttrs supportedSystems;

    # Attribute set of nixpkgs for each system:
    nixpkgsFor = forAllSystems (system:
      import inputs.nixpkgs { inherit system; });

  in {
    homeConfigurations = {
      user = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ (./. + "/profiles"+("/"+systemSettings.profile)+"/home.nix") # load home.nix from selected PROFILE
                    #  inputs.nix-flatpak.homeManagerModules.nix-flatpak # Declarative flatpaks
                    ];
          extraSpecialArgs = {
            # pass config variables from above
            inherit pkgs-stable;
            inherit systemSettings;
            inherit userSettings;
            inherit (inputs) stylix;
            inherit (inputs) hyprland-plugins;
          };
      };
    };
    nixosConfigurations = {
      system = lib.nixosSystem {
        system = systemSettings.system;
        modules = [ (./. + "/profiles"+("/"+systemSettings.profile)+"/configuration.nix") ]; # load configuration.nix from selected PROFILE
        specialArgs = {
          # pass config variables from above
          inherit pkgs-stable;
          inherit systemSettings;
          inherit userSettings;
          inherit (inputs) stylix;
        };
      };
    };

    packages = forAllSystems (system:
      let pkgs = nixpkgsFor.${system}; in
      {
        default = self.packages.${system}.install;

        install = pkgs.writeScriptBin "install" ./install.sh;
      });

    apps = forAllSystems (system: {
      default = self.apps.${system}.install;

      install = {
        type = "app";
        program = "${self.packages.${system}.install}/bin/install";
      };
    });
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      flake = false;
    };
  };
}
