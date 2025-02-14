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
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "plys"; # Define your hostname.
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
  # Optionally, you may need to select the appropriate driver version for your specific GPU.

  nixpkgs.config.allowUnfree = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.open = false;


  services = {
    xserver.enable = true;
    pipewire.enable = true;
    avahi.enable = true;
    #printing.enable = true;
    tailscale.enable = true;
    minecraft-server.enable = false;

    jellyfin.enable = false;
    radarr.enable = false;
    sonarr.enable = false;
    prowlarr.enable = false;
    mullvad-vpn.enable = false;
    transmission.enable = true;
  };

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
    desktopManager.gnome.enable = true;

    xkb.layout = "us,us";
    xkb.variant = ",colemak";
    videoDrivers = [ "nvidia" ];
  };

  # Enable sound with pipewire.
  # sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.avahi = {
    nssmdns4 = true;
    ipv4 = true;
    ipv6 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  services.minecraft-server = {
    eula = true;
    openFirewall = true;
    # package = pkgs.papermc;
  };

  programs.adb.enable = true;
  programs.fish.enable = true;
  programs.fish.promptInit = ''
    any-nix-shell fish --info-right | source
  '';
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lucas = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "Lucas Rasmussen";
    extraGroups = [ "networkmanager" "wheel" "adbusers" ];
  };

  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  programs.firefox.enable = true;
  programs.git.enable = true;

  documentation.dev.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    gnomeExtensions.blur-my-shell
    # linuxPackages.usbip
    man-pages
    man-pages-posix
    nodejs
    any-nix-shell
    neovim
    doas
    gcc
    wl-clipboard
    unzip
    ripgrep
    fd
    tree-sitter
    htop
    tldr
    gdb
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.syncthing = {
    enable = true;
    user = "lucas";
    overrideFolders = false;
    overrideDevices = false;
  };


  #   virtualisation.libvirtd.enable = true;
  #   programs.virt-manager.enable = true;

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
  system.stateVersion = "unstable"; # Did you read the comment?
}
