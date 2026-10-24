{ pkgs, ... }:

let
  # only the one TTF matrix.script asks for, not the whole 50M font pack
  matrixFont = pkgs.runCommand "plymouth-matrix-font" { } ''
    mkdir -p $out/share/fonts
    cp ${pkgs.ultimate-oldschool-pc-font-pack}/share/fonts/truetype/PxPlus_IBM_BIOS-2y.ttf $out/share/fonts/
  '';

  # plymouth 26's script plugin has no Math.Clamp, so the 2017 theme's refresh
  # callback threw every frame and never drew the typed text
  matrixTheme = pkgs.plymouth-matrix-theme.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      substituteInPlace matrix.script \
        --replace-fail 'index = Math.Clamp(time - matrix.anim_start, 0, 99999);' \
          'index = time - matrix.anim_start; if (0 > index) { index = 0; } if (index > 99999) { index = 99999; }' \
        --replace-fail 'index = Math.Int(Math.Clamp(index / matrix.step, 0, matrix.end));' \
          'index = Math.Int(index / matrix.step); if (index > matrix.end) { index = matrix.end; }'
    '';
  });
in
{
  boot.plymouth = {
    enable = true;
    theme = "matrix";
    themePackages = [ matrixTheme ];
    font = "${matrixFont}/share/fonts/PxPlus_IBM_BIOS-2y.ttf";
    # the firmware leaves the EFI framebuffer at 800x600, which plymouth 26
    # refuses to draw on unless simpledrm is forced open
    extraConfig = "UseSimpledrm=2";
  };

  boot.consoleLogLevel = 3;
  boot.kernelParams = [
    "quiet"
    "udev.log_level=3"
    "vt.global_cursor_default=0"
  ];
}
