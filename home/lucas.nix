# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # ./nvim.nix
    # ./firefox.nix
    # ./hyprland.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = false;
    desktop = "${config.home.homeDirectory}/desk";
    download = "${config.home.homeDirectory}/dwnlds";
    pictures = "${config.home.homeDirectory}/pix";
    templates = "${config.home.homeDirectory}/templ";
    videos = "${config.home.homeDirectory}/pix/vids";
    music = "${config.home.homeDirectory}/music";
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  programs.go.goPath = ".local/go";

  home = {
    username = "lucas";
    homeDirectory = "/home/lucas";
  };

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [
    mosh
    alacritty
    gcc
    wl-clipboard
    dmd
    dub
  ];


  services = {
    syncthing.enable = true;
  };

  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
  };


  programs = {
    direnv = {
      enable = true;
      # enableBashIntegration = true; # see note on other shells below
      enableFishIntegration = true;
      nix-direnv.enable = true;
    };

    # fish.enable = true; # see note on other shells below
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
