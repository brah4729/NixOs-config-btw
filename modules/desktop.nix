{ config, pkgs, ... }:
{
    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };
    services.xserver.enable = true;
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
         pkgs.xdg-desktop-portal-kde

    ];
    xdg.portal.config.common.default = "*";
    services.flatpak.enable = true;
    services.gvfs.enable = true;
    services.displayManager.ly.enable = true;
}
