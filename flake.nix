{
  description = "NixOS Configuration with Hyprland";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
    url = "github:sodiboo/niri-flake";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  };

  outputs = { self, nixpkgs, home-manager, spicetify-nix, noctalia, niri } @ inputs: {
    nixosConfigurations.nixos-main = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        inputs.niri.nixosModules.niri  

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };

            users.e = {
              imports = [
                ./home/users/e.nix
                spicetify-nix.homeManagerModules.default
              ];
            };

            users.jsdev = {
              imports = [ ./home/users/js.nix ];
            };

            users.php = {
              imports = [ ./home/users/php.nix ];
            };

            users.pydev = {
              imports = [ ./home/users/py.nix ];
            };
          };
        }
      ];
    };
  };
}