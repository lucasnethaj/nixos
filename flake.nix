{
  description = "my nixos configurations";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      # url = "github:nix-community/home-manager";
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";

  };

  outputs = { self, nixpkgs, home-manager, ... }:
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
          # > Our main nixos configuration file <
          modules = [
            ./nix/retard/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.users.lucas.imports = [
                ./home/lucas.nix
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
          # > Our main home-manager configuration file <
          modules = [
            ./home-manager/home.nix
          ];
        };

        "lucas@retard-driver" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          # > Our main home-manager configuration file <
        };
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    };
}
