{ pkgs, ... }:
{
  imports = [
    ../../common/packages.nix
  ];
  # Packages that will be installed in all NixOS installations
  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];
}
