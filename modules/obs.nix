{config, pkgs, ...}:
{
    environment.systemPackages = [
    (pkgs.wrapOBS {
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi #for AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
    ];
  })
];
}