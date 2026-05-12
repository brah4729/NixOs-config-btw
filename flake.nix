home-manager.nixosModules.home-manager
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users = {
      e = {
        imports = [
          ./home/users/e.nix
          spicetify-nix.homeManagerModules.default
        ];
      };
      # Uncomment when you add these users to the system:
      # pydev = { imports = [ ./home/users/pydev.nix ]; };
      # jsdev  = { imports = [ ./home/users/jsdev.nix ]; };
    };
  };
}