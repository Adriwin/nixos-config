{
  imports = [
    ./waybar.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./fuzzel.nix
    ./mako.nix
    ./obs-studio.nix
    ./hyprpaper.nix
    ./wireplumber.nix
    ./easyeffects.nix
    ./usb.nix
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "gruvbox-dark";
        color-scheme = "prefer-dark";
      };
    };
  };
  gtk = {
    enable = true;
    colorScheme = "dark";
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
}
