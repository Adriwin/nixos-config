{
  description = "NixOS system configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS profiles to optimize settings for different hardware
    hardware.url = "github:nixos/nixos-hardware";

    # https://nix.catppuccin.com/getting-started/flakes/
    catppuccin.url = "github:catppuccin/nix/release-25.11";

    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      catppuccin,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      users = {
	adriwin = {        
          avatar = ./files/avatar/face.jpg;
          email = "grzegorzpietrucha15@gmail.com";
          fullName = "Grzegorz Pietrucha";
          name = "adriwin";
        };
	work = {
          inherit (users.adriwin) avatar fullName;
          email = "grzegorz.pietrucha@iqvia.com";
          name = "grzegorz.pietrucha@iqvia.com"; # OS username stays the same
        };
      };

      helpers = import ./lib/mksystem.nix {
        inherit
          self
          inputs
          outputs
          users
          ;
      };
      inherit (helpers) mkNixosConfiguration mkDarwinConfiguration;
    in
    {
      overlays = import ./overlays { inherit inputs; };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;

      nixosConfigurations = {
        desktop = mkNixosConfiguration "desktop" "adriwin";
      };

      darwinConfigurations = {
        iqvia-mbp = mkDarwinConfiguration "iqvia-mbp" "work";
      };
    };
}
