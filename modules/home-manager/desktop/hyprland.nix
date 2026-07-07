{
  programs.kitty.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    extraConfig = ''
      local mod = "SUPER"
      local mainMod = "SUPER"

      hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
      hl.env("XDG_SESSION_TYPE", "wayland")
      hl.env("XDG_SESSION_DESKTOP", "Hyprland")
      hl.env("QT_QPA_PLATFORM", "wayland")
      hl.env("XDG_SCREENSHOTS_DIR", "~/screens")
      hl.env("GDK_DPI_SCALE", "1.2")
      hl.env("GDK_SCALE", "1.2")
      hl.env("XCURSOR_SIZE", "24")
      hl.env("GRIMBLAST_HIDE_CURSOR", "0")
      hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

      hl.config({
          xwayland = {
            force_zero_scaling = true;
          };
          debug = {
              disable_logs = false,
              enable_stdout_logs = true,
          },
          input = {
              kb_layout = "pl",
              follow_mouse = 1,
              touchpad = {
                  natural_scroll = false,
              },
              sensitivity = 0,
          },
          general = {
              gaps_in = 5,
              gaps_out = 20,
              border_size = 3,
              col = {
                  active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
                  inactive_border = "rgba(595959aa)",
              },
              layout = "dwindle",
          },
          decoration = {
              rounding = 10,
              blur = {
                  enabled = true,
                  size = 16,
                  passes = 2,
                  new_optimizations = true,
              },
          },
          dwindle = {
              preserve_split = true,
          },
          gestures = {
              workspace_swipe_invert = false,
              workspace_swipe_distance = 200,
              workspace_swipe_forever = true,
          },
          misc = {
              animate_manual_resizes = true,
              animate_mouse_windowdragging = true,
              enable_swallow = true,
              disable_hyprland_logo = true,
          },
      })

      -- Animations
      hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
      hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
      hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
      hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
      hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
      hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
      hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })

      -- Window rules
      hl.window_rule({ match = { class = "org.pulseaudio.pavucontrol" }, float = true, center = true, pin = true })
      hl.window_rule({ match = { class = ".blueman-manager-wrapped" }, float = true, center = true, pin = true })
      hl.window_rule({ match = { class = "steam" }, workspace = "8 silent" })
      hl.window_rule({ match = { class = "signal-desktop" }, workspace = "9 silent" })
      hl.window_rule({ match = { class = "spotify" }, workspace = "10 silent" })
      hl.window_rule({ match = { class = "brave-main" }, workspace = "6 silent" })
      hl.window_rule({ match = { class = "brave-media" }, workspace = "7 silent" })
      hl.window_rule({ match = { class = "brave-discord" }, workspace = "9 silent" })

      -- Kitty window rules
      hl.window_rule({ match = { class = "kitty", title = "kitty-zd" }, workspace = "1 silent" })
      hl.window_rule({ match = { class = "kitty", title = "kitty-grid-1" }, workspace = "2 silent" })
      hl.window_rule({ match = { class = "kitty", title = "kitty-grid-2" }, workspace = "2 silent" })
      hl.window_rule({ match = { class = "kitty", title = "kitty-grid-3" }, workspace = "2 silent" })
      hl.window_rule({ match = { class = "kitty", title = "kitty-grid-4" }, workspace = "2 silent" })

      -- Autostart
      hl.on("hyprland.start", function()
          hl.exec_cmd("wl-paste --type text --watch cliphist store")
          hl.exec_cmd("wl-paste --type image --watch cliphist store")
          hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
          hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
          hl.exec_cmd("sleep 2 && waybar > /tmp/waybar.log 2>&1 &")
          hl.exec_cmd("mako")
          hl.exec_cmd("blueman-applet")
          
          hl.exec_cmd("setpriv --ambient-caps -all steam", { workspace = "8 silent" })
          hl.exec_cmd("setpriv --ambient-caps -all signal-desktop", { workspace = "9 silent" })
          hl.exec_cmd("setpriv --ambient-caps -all spotify", { workspace = "10 silent" })
          
          hl.exec_cmd([[brave --class=brave-main]], { workspace = "6 silent" })
          hl.exec_cmd([[brave --user-data-dir=$HOME/.config/BraveSoftware/Brave-Browser-Media --class=brave-media]], { workspace = "7 silent" })
          hl.exec_cmd([[brave --user-data-dir=$HOME/.config/BraveSoftware/Brave-Browser-Discord --class=brave-discord]], { workspace = "9 silent" })
          
          -- Kitty
          hl.exec_cmd([[kitty --title kitty-zd zsh -ic "zd; exec zsh"]], { workspace = "1 silent" })
          hl.exec_cmd("kitty --title kitty-grid-1", { workspace = "2 silent" })
          hl.exec_cmd("kitty --title kitty-grid-2", { workspace = "2 silent" })
          hl.exec_cmd("kitty --title kitty-grid-3", { workspace = "2 silent" })
          hl.exec_cmd("kitty --title kitty-grid-4", { workspace = "2 silent" })
          
          hl.exec_cmd("gamemoded")
          hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
          hl.exec_cmd("openrgb --startminimized --profile 'Bloody'")
      end)

      -- Workspaces
      hl.workspace_rule({ workspace = "1", monitor = "DP-2" })
      hl.workspace_rule({ workspace = "2", monitor = "DP-3" })
      hl.workspace_rule({ workspace = "3", monitor = "DP-2" })
      hl.workspace_rule({ workspace = "4", monitor = "DP-1", default = true })
      hl.workspace_rule({ workspace = "5", monitor = "DP-1" })
      hl.workspace_rule({ workspace = "6", monitor = "DP-1" })
      hl.workspace_rule({ workspace = "7", monitor = "DP-1" })
      hl.workspace_rule({ workspace = "8", monitor = "DP-2" })
      hl.workspace_rule({ workspace = "9", monitor = "DP-3" })
      hl.workspace_rule({ workspace = "10", monitor = "DP-2" })

      -- Binds
      hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy"))
      hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("kitty"))
      hl.bind(mainMod .. " + Q", hl.dsp.window.close())
      hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("hyprctl dispatch exit"))
      hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("thunar"))
      hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
      hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("fuzzel --show drun"))
      hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
      hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
      hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

      hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
      hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
      hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
      hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

      hl.bind(mainMod .. " + SHIFT + left", hl.dsp.exec_cmd("hyprctl dispatch swapwindow l"))
      hl.bind(mainMod .. " + SHIFT + right", hl.dsp.exec_cmd("hyprctl dispatch swapwindow r"))
      hl.bind(mainMod .. " + SHIFT + up", hl.dsp.exec_cmd("hyprctl dispatch swapwindow u"))
      hl.bind(mainMod .. " + SHIFT + down", hl.dsp.exec_cmd("hyprctl dispatch swapwindow d"))

      hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.resize({ x = -60, y = 0, relative = true }))
      hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 60, y = 0, relative = true }))
      hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.resize({ x = 0, y = -60, relative = true }))
      hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.resize({ x = 0, y = 60, relative = true }))

      for i = 1, 9 do
          hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = tostring(i) }))
          hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = tostring(i), follow = false }))
      end
      hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = "10" }))
      hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = "10", follow = false }))

      hl.bind(mainMod .. " + grave", hl.dsp.workspace.toggle_special(""))
      hl.bind(mainMod .. " + SHIFT + grave", hl.dsp.window.move({ workspace = "special" }))

      hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
      hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

      hl.bind(mainMod .. " + F3", hl.dsp.exec_cmd("brightnessctl -d *::kbd_backlight set +33%"))
      hl.bind(mainMod .. " + F2", hl.dsp.exec_cmd("brightnessctl -d *::kbd_backlight set 33%-"))

      hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"))
      hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"))
      hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"))
      hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pamixer --default-source -t"))

      hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
      hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
      hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
      hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
      hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"))

      hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"))
      hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"))

      hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd([[alacritty -e sh -c "rb"]]))
      hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd([[alacritty -e sh -c "conf"]]))
      hl.bind(mainMod .. " + SHIFT + H", hl.dsp.exec_cmd([[alacritty -e sh -c "nvim ~/nix/home-manager/modules/hyprland.nix"]]))
      hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd([[alacritty -e sh -c "nvim ~/nix/home-manager/modules/waybar.nix"]]))

      hl.bind("Print", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | swappy -f -]]))
      hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | swappy -f -]]))

      hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))
      hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("pkill -SIGUSR2 waybar"))

      hl.bind(mainMod .. " + SHIFT + G", hl.dsp.exec_cmd("~/.config/hypr/gamemode.sh"))

      hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
      hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
    '';
  };
}
