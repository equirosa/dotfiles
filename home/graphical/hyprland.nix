{ pkgs
, lib
, config
, ...
}:
let
  inherit (lib.lists) range;
  inherit (builtins) concatLists;
  inherit (config.programs) rofi;
  inherit
    (pkgs)
    btop
    lf
    pulsemixer
    tor-browser-bundle-bin
    tremc
    wezterm
    ;
  gaps_in = 2;
  mod = "SUPER";
  leftMon = "DP-1";
  rightMon = "HDMI-A-1";
  leftWorkspaces = range 1 6;
  rightWorkspaces = range 7 10;
  allWorkspaces = leftWorkspaces ++ rightWorkspaces;
  useRightNum = num: toString (if num == 10 then 0 else num);
  defaultBrowser = "firefox -P default";
  defaultTerm = "wezterm";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [
        "QT_QPA_PLATFORM,wayland;xcb"
        "WLR_NO_HARDWARE_CURSORS,1"
      ];
      monitor = [
        "${leftMon},preferred,0x0,auto"
        "${rightMon},1920x1080@60,1920x0,1"
      ];
      general = {
        inherit gaps_in;
        gaps_out = gaps_in * 2;
        border_size = 2;
        "col.active_border" = "rgba(E323BEEE) rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };
      exec-once = [
        "transmission-daemon"
        "beeper"
        "swww"
        defaultBrowser
        "firefox -P media"
      ];
      workspace = concatLists [
        (map (num: "${toString num},monitor:${leftMon}") leftWorkspaces)
        (map (num: "${toString num},monitor:${rightMon}") rightWorkspaces)
      ];
      input = {
        kb_layout = "us,latam";
        kb_options = "grp:win_space_toggle";
        follow_mouse = true;
        touchpad.natural_scroll = false;
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };
      misc = {
        vrr = true;
        enable_swallow = true;
        swallow_regex = "^(foot)";
      };
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          new_optimizations = false;
        };
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true; # you probably want this
      };
      bind = concatLists [
        (map (str: "${mod} SHIFT, ${str}") (concatLists [
          [
            "E, exec, emacsclient --create-frame"
            "Q, killactive,"
            "W, exec, tor-browser"
          ]
          (map (key: "${key}, movewindow, d") [ "j" "DOWN" ])
          (map (key: "${key}, movewindow, l") [ "h" "LEFT" ])
          (map (key: "${key}, movewindow, r") [ "l" "RIGHT" ])
          (map (key: "${key}, movewindow, u") [ "k" "UP" ])
          (map (num: "${useRightNum num}, movetoworkspacesilent, ${toString num}")
            allWorkspaces)
        ]))
        (map (str: "${mod}, ${str}")
          (concatLists [
            [
              "A, exec, ${defaultTerm} -e ${pulsemixer}/bin/pulsemixer"
              "D, exec, rofi -show run"
              "E, exec, kitty aerc"
              "F, fullscreen, 0"
              "I, exec, ${defaultTerm} -e ${btop}/bin/btop"
              "M, fullscreen, 1"
              "P, exec, emoji"
              "R, exec, ${defaultTerm} -e lf"
              "RETURN, exec, ${defaultTerm}"
              "S, exec, search"
              "T, exec, ${defaultTerm} -e tremc"
              "V, togglefloating,"
              "W, exec, firefox"
              "X, exec, swaylock"
              "Z, exec,password-menu"
              "mouse_down, workspace, e+1"
              "mouse_up, workspace, e-1"
            ]
            (map (key: "${key}, movefocus, d") [ "j" "DOWN" ])
            (map (key: "${key}, movefocus, l") [ "h" "LEFT" ])
            (map (key: "${key}, movefocus, r") [ "l" "RIGHT" ])
            (map (key: "${key}, movefocus, u") [ "k" "UP" ])
            (map (num: "${useRightNum num}, workspace, ${toString num}") allWorkspaces)
          ]))
        [
          ", Print, exec, screenshot"
          "ALT SHIFT, F, fakefullscreen,"
        ]
      ];
      bindm = [
        "${mod}, mouse:272, movewindow"
        "${mod}, mouse:273, resizewindow"
      ];
      windowrulev2 = concatLists [
        [ "maximize,class:^(firefox)$,title:Picture-in-Picture" ]
        (map (id: "workspace 9 silent:${id}")
          [ "class:^(Beeper)" "title:^(aerc)" ])
        (map (rule: "${rule},class:^([Ss]team|.gamescope-wrapped)")
          [ "workspace 6 silent" "tile" ])
        (map (rule: "${rule},class:^(gcr-prompter|[Rr]ofi)")
          [ "dimaround" "float" "pin" ])
        (map (rule: "${rule},class:org.remmina.Remmina")
          [ "workspace 1 silent" "fakefullscreen" ])
      ];
    };
  };
}
