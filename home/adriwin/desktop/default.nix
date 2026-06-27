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

  wayland.windowManager.hyprland.extraConfig = ''
    hl.monitor({
      output = "DP-1",
      mode = "1920x1080@144",
      position = "0x0",
      scale = 1,
    })

    hl.monitor({
      output = "DP-2",
      mode = "1920x1080@144",
      position = "1920x0",
      scale = 1,
    })

    hl.monitor({
      output = "DP-3",
      mode = "1920x1080@144",
      position = "3840x0",
      scale = 1,
      transform = 3,
    })
  '';

  services.hyprpaper.settings.wallpaper = [
    "DP-1,~/.config/wallpapers/default.jpg"
    "DP-2,~/.config/wallpapers/default.jpg"
    "DP-3,~/.config/wallpapers/default.jpg"
  ];

  home.file.zellij-layout.source = config.lib.file.mkOutOfStoreSymlink ./zellij-layout.kdl;
  home.file.zellij-layout.target = "./default.kdl";

  home.activation.warmZshCompletions = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD ${pkgs.zsh}/bin/zsh -i -c exit 2>/dev/null || true
  '';
}
