{
  #yay flakes nothing much just for spicetify and also for home manager and also for nixpkgs so yeah if you want to add something just add it to the appropriate section and it will work by default also if you want to add something that is common for all the users just add it to the default.nix file and it will be applied to all the users by default
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
          };
        }
      ];
    };
  };
}