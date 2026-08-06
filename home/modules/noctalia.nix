{ inputs, pkgs, ... }:
{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;
    systemd.enable = true;   # runs it as a user service, auto-restarts on config change
    settings = {
      # you can leave this empty for now and configure via the GUI,
      # or start filling in options once you've seen the defaults
    };
  };
}