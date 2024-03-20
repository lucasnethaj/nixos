{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    # NUR Packages
    nur.url = "github:nix-community/NUR";

    # Home manager
    home-manager = { 
        url = "github:nix-community/home-manager/release-23.11";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";

  };

  outputs = { self, nixpkgs, home-manager, nur, ... }@attrs: 
  {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      plys = nixpkgs.lib.nixosSystem {
        # specialArgs = { inherit inputs outputs; }; # Pass flake inputs to our config
        # > Our main nixos configuration file <
        modules = [ ./nix/configuration.nix ];
      };

      retard-driver = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = attrs; # Pass flake inputs to our config
# > Our main nixos configuration file <
          modules = [ 
              ./nix/retard/configuration.nix
              home-manager.nixosModules.home-manager
              {
                  home-manager.extraSpecialArgs = attrs; # allows access to flake inputs in hm modules
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
        extraSpecialArgs = attrs; # Pass flake inputs to our config
        # > Our main home-manager configuration file <
        modules = [ 
            ./home-manager/home.nix
        ];
      };

      "lucas@retard-driver" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = attrs; # Pass flake inputs to our config
        # > Our main home-manager configuration file <
      };
    };
  };
}
