{
  nhModules,
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    "${nhModules}/common"
    "${nhModules}/desktop"
  ];

  # stateVersion: set to the NixOS release this machine was FIRST installed with.
  # Do NOT change this on upgrades. See: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "26.05";

  wayland.windowManager.hyprland.settings.monitor = [
    "HDMI-A-1, 1920x1080, 0x0, 1"
    "DP-1, 1920x1080, 1920x0, 1"
  ];

  services.hyprpaper.settings.wallpaper = [
    "HDMI-A-1,~/.config/wallpapers/default.jpg"
    "DP-1,~/.config/wallpapers/default.jpg"
  ];

  home.file.zellij-layout.source = config.lib.file.mkOutOfStoreSymlink ./zellij-layout.kdl;
  home.file.zellij-layout.target = "./default.kdl";

  home.activation.warmZshCompletions = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD ${pkgs.zsh}/bin/zsh -i -c exit 2>/dev/null || true
  '';
}
