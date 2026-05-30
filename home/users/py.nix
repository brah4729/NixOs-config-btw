# /etc/nixos/home/users/py.nix
{ pkgs, ... }:
{
  imports = [ ../default.nix ];

  home.username = "pydev";
  home.homeDirectory = "/home/pydev";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    # Python with packages bundled in — the NixOS way
    (python3.withPackages (ps: with ps; [
      pip          # works correctly inside withPackages
      virtualenv
      jupyter
      ipykernel
    ]))

    # Standalone tools (not python packages)
    ruff      # linter
    pyright   # LSP
    poetry    # dependency manager
    uv        # fast pip replacement, great for venvs
  ];
}