{
  description = "NixOS Configuration with Hyprland";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-hermes.url = "github:0xrsydn/nix-hermes-agent";   # <- fixed, top-level now
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
    claude-desktop.url = "github:k3d3/claude-desktop-linux-flake";
};
  outputs = { self, nixpkgs, home-manager, spicetify-nix, noctalia, niri, lanzaboote, claude-desktop, nix-hermes } @ inputs: {
    nixosConfigurations.nixos-main = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        inputs.niri.nixosModules.niri  
        inputs.lanzaboote.nixosModules.lanzaboote
        home-manager.nixosModules.home-manager
        nix-hermes.nixosModules.hermes-agent
  ./hermes.nix   
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