{ config, pkgs, ... }:
{
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      # Battery threshold
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0  = 80;

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
