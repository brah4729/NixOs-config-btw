{ inputs, pkgs, ... }:
{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;
    systemd.enable = false;
    settings = { };
  };

  home.packages = [
    inputs.noctalia.packages.${pkgs.system}.default
  ];
}