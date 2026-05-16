{config, pkgs, ...}:
{
# Enable the OpenSSH daemon
  # configuration.nix
services.openssh = {
  enable = true;
  settings = {
    PermitRootLogin = "no";
    PasswordAuthentication = true; # set to false if using keys only
  };
};
# configuration.nix
networking.firewall = {
  enable = true;
  allowedTCPPorts = [ 22 ];
};
}