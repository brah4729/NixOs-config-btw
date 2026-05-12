{ config, pkgs, inputs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
programs.home-manager.enable = true;

  programs.spicetify = {
    enable = true;
    colorScheme = "TokyoNight";
    theme = spicePkgs.themes.text;
   # Enable the Marketplace app here
    enabledCustomApps = with spicePkgs.apps; [
      marketplace
    ];
     

    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
      shuffle

    ];
  };



  home.username = "e";
  home.homeDirectory = "/home/e";
  home.stateVersion = "24.05";

 
 


  # Git configuration
  programs.git = {
    enable = true;
    userName = "brah4729";  # CHANGE THIS
    userEmail = "brah4729@users.noreply.github.com";  # CHANGE THIS
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };

  # Bash configuration
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ll = "ls -lah";
      ls = "eza --icons";
      ".." = "cd ..";
      btw = "echo 'I use NixOS btw'";
    };
    
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec hyprland
      fi
    '';
  };

  # Neovim with LazyVim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = false;
    vimAlias = false;

    
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
      nvim-treesitter.withAllGrammars
    ];
    
    extraLuaConfig = ''
      -- Bootstrap lazy.nvim
      local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
      if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
          "git",
          "clone",
          "--filter=blob:none",
          "https://github.com/folke/lazy.nvim.git",
          "--branch=stable",
          lazypath,
        })
      end
      vim.opt.rtp:prepend(lazypath)

      -- LazyVim setup
      require("lazy").setup({
        spec = {
          { "LazyVim/LazyVim", import = "lazyvim.plugins" },
          { import = "plugins" },
        },
        defaults = {
          lazy = false,
          version = false,
        },
        checker = { enabled = true },
        performance = {
          rtp = {
            disabled_plugins = {
              "gzip",
              "tarPlugin",
              "tohtml",
              "tutor",
              "zipPlugin",
            },
          },
        },
      })

      -- Basic settings
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.mouse = "a"
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.expandtab = true
      vim.opt.shiftwidth = 2
      vim.opt.tabstop = 2
    '';
  };



  # Foot terminal - Fast Wayland terminal
  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "monospace:size=12";
        dpi-aware = "yes";
      };
      
      mouse = {
        hide-when-typing = "yes";
      };
      
      colors = {
        alpha = "0.95";
        # Tokyo Night colors
        background = "1a1b26";
        foreground = "c0caf5";
        
        regular0 = "15161e";
        regular1 = "f7768e";
        regular2 = "9ece6a";
        regular3 = "e0af68";
        regular4 = "7aa2f7";
        regular5 = "bb9af7";
        regular6 = "7dcfff";
        regular7 = "a9b1d6";
        
        bright0 = "414868";
        bright1 = "f7768e";
        bright2 = "9ece6a";
        bright3 = "e0af68";
        bright4 = "7aa2f7";
        bright5 = "bb9af7";
        bright6 = "7dcfff";
        bright7 = "c0caf5";
      };
    };
  };

  # Firefox
  programs.firefox = {
    enable = true;
  };

    
    
   
  # Additional packages
  home.packages = with pkgs; [
    # System utilities
    btop
    fastfetch
    playerctl
    pavucontrol
    
    # Development
    gcc
    nodejs
    python3
    
    # Media
    mpv
    imv
    
    # Office
    libreoffice-fresh
    
    # System tools
    brightnessctl
    wlogout
    
    # Archive
    p7zip
    unrar
    
    # Icons
    papirus-icon-theme
  ];

  # Environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
  };

  # Create LazyVim config directory
  home.file.".config/nvim/lua/plugins/.keep".text = "";
}
