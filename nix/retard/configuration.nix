# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_5;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "retard-driver"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };

  hardware.graphics.enable = true;
  # hardware.opengl.enable = true;
  # Optionally, you may need to select the appropriate driver version for your specific GPU.

  services = {
    xserver.enable = true;
    pipewire.enable = true;
    avahi.enable = true;
    printing.enable = true;
    tailscale.enable = true;
    fwupd.enable = true;
    pcscd.enable = true;
    power-profiles-daemon.enable = true;
    gnome.gnome-keyring.enable = true;

    # jellyfin.enable = false;
    # radarr.enable = true;
    # sonarr.enable = true;
    # prowlarr.enable = true;
    # mullvad-vpn.enable = true;
    # transmission.enable = true;
  };

  virtualisation.docker.enable = true;
  # virtualisation.waydroid.enable = true;
  # virtualisation.libvirtd.enable = true;
  # programs.virt-manager.enable = true;

  services.jellyfin = {
    openFirewall = true;
  };

  users.groups.radarr = { };
  users.groups.sonarr = { };

  users.users.sonarr = {
    group = "sonarr";
    isSystemUser = true;
    extraGroups = [ "transmission" "jellyfin" ];
  };

  users.users.radarr = {
    group = "radarr";
    isSystemUser = true;
    extraGroups = [ "transmission" "jellyfin" ];
  };

  services.xserver = {
    displayManager.gdm.enable = true;
    # desktopManager.gnome.enable = true;
    xkb.layout = "us";
    xkb.variant = "";
    videoDrivers = [ "intel" ];
  };

  xdg.portal.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.avahi = {
    nssmdns4 = true;
    # nssmdns = true;
    ipv4 = true;
    ipv6 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  programs.fish.enable = true;
  programs.adb.enable = true;
  programs.gnupg.agent.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lucas = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "Lucas Rasmussen";
    extraGroups = [ "networkmanager" "wheel" "adbusers" "docker" "input" ];
  };

  users.users.niko = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "Nikolaj Frederiksen";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gnomeExtensions.blur-my-shell
    gnomeExtensions.syncthing-indicator
    fragments
    unzip
    wget
    htop
    neovim
    doas
    thunderbird
    fractal
    ipu6ep-camera-hal
    ipu6-camera-bins
    dmd
    ldc
    dtools

    swww
    zathura
    imv
    wofi
    blueberry
    brightnessctl
    grimblast
    wdisplays
    swaynotificationcenter
    pavucontrol

  ];

  fonts.packages = with pkgs; [
    nerdfonts
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  qt.enable = true;
  qt.platformTheme = "gnome";
  qt.style = "adwaita-dark";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.waybar.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  networking.firewall.allowedUDPPorts = [ 60000 60001 60002 60003 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?



  # # Nixops experimentation
  # virtualisation.libvirtd.enable = true;
  # users.extraUsers.lucas.extraGroups = [ "libvirtd" ];
  # networking.firewall.checkReversePath = false;

  # containers.tagion = {
  #   autoStart = true;
  #
  #     config = { config, pkgs, tagion, ... }: {
  #       system.stateVersion = "23.11";
  #
  #       # services.nextcloud = {
  #       #   enable = true;
  #       #   package = pkgs.nextcloud28;
  #       #   hostName = "localhost";
  #       #   config.adminpassFile = "${pkgs.writeText "adminpass" "test123"}"; # DON'T DO THIS IN PRODUCTION - the password file will be world-readable in the Nix Store!
  #       # };
  #       environment.systemPackages = [
  #           tagion #.packages.x86_64-linux.tagion
  #       ];
  #
  #       # inputs.tagion.services.tagion = {
  #       #     enable = true;
  #       # };
  #   };
  # };
}
