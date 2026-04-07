{config, pkgs, ...}:
{

  # Enable flakes
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
nix.settings = {
    # CRITICAL: Resource limits
    cores = 6;
    max-jobs = 1;
    
    # CRITICAL: Use binary cache, don't build
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://cuda-maintainers.cachix.org"  # For CUDA packages
    ];
    
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
    
    # Don't build if not in cache - just fail instead
    fallback = false;
    
    # Keep system responsive
    min-free = 4294967296;  # Keep 4GB free
   }; 
}