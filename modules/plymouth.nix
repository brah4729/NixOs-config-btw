{ pkgs, ... }:

let
  # only the one TTF matrix.script asks for, not the whole 50M font pack
  matrixFont = pkgs.runCommand "plymouth-matrix-font" { } ''
    mkdir -p $out/share/fonts
    cp ${pkgs.ultimate-oldschool-pc-font-pack}/share/fonts/truetype/PxPlus_IBM_BIOS-2y.ttf $out/share/fonts/
  '';
in
{
  boot.plymouth = {
    enable = true;
    theme = "matrix";
    themePackages = [ pkgs.plymouth-matrix-theme ];
    font = "${matrixFont}/share/fonts/PxPlus_IBM_BIOS-2y.ttf";
  };

  boot.consoleLogLevel = 3;
  boot.kernelParams = [
    "quiet"
    "udev.log_level=3"
    "vt.global_cursor_default=0"
  ];
}
