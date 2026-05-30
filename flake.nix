{
  description = "NixOS Configuration with Hyprland";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = { self, nixpkgs, home-manager, spicetify-nix } @ inputs: {
    nixosConfigurations.nixos-main = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix

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