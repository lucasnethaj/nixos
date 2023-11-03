{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # NUR Packages
    nur.url = github:nix-community/NUR;

    # Home manager
    home-manager = { 
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";

    hyprland.url = "github:hyprwm/Hyprland";

  };

  outputs = { nixpkgs, home-manager, hyprland, nur, ... }@inputs: {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      plys = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; }; # Pass flake inputs to our config
        # > Our main nixos configuration file <
        modules = [ ./nix/configuration.nix ];
      };

      retard-driver = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; }; # Pass flake inputs to our config
# > Our main nixos configuration file <
          modules = [ 
              ./nix/retard/configuration.nix 
              home-manager.nixosModules.home-manager
              {
                  home-manager.extraSpecialArgs = { inherit inputs; }; # allows access to flake inputs in hm modules
                  home-manager.users.lucas.imports = [ 
                      ./home/lucas.nix 
                      nur.nixosModules.nur
                  ];
              }
              ];
      };

    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "lucas@plys" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
        # > Our main home-manager configuration file <
        modules = [ 
		hyprland.homeManagerModules.default
		{wayland.windowManager.hyprland.enable = true;}
		./home-manager/home.nix
        ];
      };

      "lucas@retard-driver" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
        # > Our main home-manager configuration file <
      };
    };
  };
}
