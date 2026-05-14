{config, pkgs, ...}:
{
services.power-profiles-daemon.enable = false; # disable if using GNOME
services.tlp = {
  enable = true;
  settings = {
    START_CHARGE_THRESH_BAT0 = 75;
    STOP_CHARGE_THRESH_BAT0  = 80;

  };
  PLATFORM_PROFILE_ON_BAT = "quiet";
  PLATFORM_PROFILE_ON_AC  = "performance";   # ← changed this

  CPU_ENERGY_PERF_POLICY_ON_BAT  = "power";
  CPU_ENERGY_PERF_POLICY_ON_AC   = "performance";  # ← max perf on AC

  CPU_BOOST_ON_BAT = 0;   # no turbo on battery
  CPU_BOOST_ON_AC  = 1;   # full turbo on AC
};
}
