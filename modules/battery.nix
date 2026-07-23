{ config, pkgs, ... }:
{
  services.power-profiles-daemon.enable = false;
   systemd.services.asus-battery-charge-limit = {
    description = "Set ASUS battery charge threshold";
    wantedBy = [ "multi-user.target" ];
    after = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo 80 > /sys/class/power_supply/BAT0/charge_control_end_threshold'";
    };
  };

  services.tlp = {
    enable = true;
    settings = {

      # Platform profiles
      PLATFORM_PROFILE_ON_BAT = "quiet";
      PLATFORM_PROFILE_ON_AC  = "performance";

      # CPU policy
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC  = "performance";

      # Turbo boost
      CPU_BOOST_ON_BAT = 0;
      CPU_BOOST_ON_AC  = 1;
    };
  };
}
