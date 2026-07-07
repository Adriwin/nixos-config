{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wine
    # support both 32-bit and 64-bit applications
    wineWow64Packages.stable

    # winetricks (all versions)
    winetricks

    # native wayland support (unstable)
    wineWow64Packages.waylandFull

    bottles
  ];
}
