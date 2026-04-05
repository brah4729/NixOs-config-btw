{config, pkgs, ...}:
{
    fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-color-emoji
        font-awesome
        jetbrains-mono
        fira-code
        hack-font 
        nerd-fonts.jetbrains-mono
    ];
    fonts.fontconfig = {
        enable = true;
        defaultFonts = {
            monospace = [ "JetBrains Mono Nerd Font" "DejaVu Sans Mono" ];
            sansSerif = [ "Noto Sans" "DejaVu Sans" ];
            serif = [ "Noto Serif" "DejaVu Serif" ];
        };
    };
}