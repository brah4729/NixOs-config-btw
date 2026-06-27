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
services.tailscale.enable = true;
  networking.nftables.enable = true;
networking.firewall = {
  enable = true;
  allowedTCPPorts = [ 22 ];
    # Always allow traffic from your Tailscale network
    trustedInterfaces = [ config.services.tailscale.interfaceName ];
    # Allow the Tailscale UDP port through the firewall
    allowedUDPPorts = [ config.services.tailscale.port ];
    extraInputRules = ''
      iifname "tailscale0" accept
    '';
};
}
