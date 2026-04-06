{config, pkgs, ...}:
{
    #docker 
    virtualisation.docker = {
        enable = true;
        enableOnBoot = false;
    };
}