{ pkgs, ... }:

{
  programs.fuzzel = {
    enable = true;
  };

  xdg.desktopEntries = {
    moviebattles2 = {
      name = "Movie Battles II";
      comment = "Launch MB2 in NixOS native 32-bit shell";

      # Clean, standard command without chained logic or illegal quotes
      exec = "${pkgs.nix}/bin/nix-shell /home/adriwin/nixos-config/modules/home-manager/desktop/mb2-shell.nix --run ./mbii.i386";

      icon = "steam_icon_6020";
      terminal = false;
      categories = [ "Game" ];

      # This forces Home Manager to inject the native "Path" entry cleanly into the key/value desktop spec
      settings = {
        Path = "/mnt/sdc/SteamLibrary/steamapps/common/Jedi Academy/GameData";
      };
    };
  };
}
