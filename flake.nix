{
  description = "NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    catppuccin.url = "github:catppuccin/nix";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-24.11";

      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , spicetify-nix
    , catppuccin
    , zen-browser
    , hyprpanel
    , home-manager
    , nixvim
    , ...
    }@inputs:
    {
      nixosConfigurations.lake = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };

        modules = [
          { nixpkgs.overlays = [ inputs.hyprpanel.overlay ]; }

          ./config/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.backupFileExtension = "HMBackup";
            home-manager.useUserPackages = true;

            home-manager.users.river.imports = [
              ./home
              catppuccin.homeManagerModules.catppuccin
            ];

            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
          }

        ];
      };
    };
}
