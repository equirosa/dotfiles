{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe;
  inherit (lib.lists) forEach range;
  inherit (builtins) concatStringsSep;
  inherit
    (pkgs)
    btop
    pulsemixer
    ;
  gaps = 2;
  leftMon = "DP-1";
  rightMon = "HDMI-A-1";
  leftWorkspaces = range 1 6;
  rightWorkspaces = range 7 10;
  allWorkspaces = leftWorkspaces ++ rightWorkspaces;
  addToFile = concatStringsSep "\n";
  assignWorkspaces = monitor: workspaces:
    addToFile (map (number: "workspace=${toString number},monitor:${monitor}")
      workspaces);
  genWinRule2 = rules: regexs:
    addToFile (map (regex: "${addToFile (map (rule: "windowrulev2=${rule},${regex}") rules)}") regexs);
in {
  wayland.windowManager.hyprland = {
    enable = true;
    recommendedEnvironment = true;
    extraConfig = ''
      monitor=${leftMon},preferred,auto,auto
      monitor=${rightMon},1920x1080@60,1920x0,1

      # Assign workspaces
      ${assignWorkspaces leftMon leftWorkspaces}
      ${assignWorkspaces rightMon rightWorkspaces}

      # Some default env vars.
      env = XCURSOR_SIZE,24

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
          kb_layout = us,latam
          kb_variant =
          kb_model =
          kb_options =grp:win_space_toggle
          kb_rules =
          follow_mouse = 1
          touchpad {
              natural_scroll = no
          }
          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }

      general {
          gaps_in = ${toString gaps}
          gaps_out = ${toString (gaps * 2)}
          border_size = 2
          col.active_border = rgba(E323BEEE) rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)
          layout = dwindle
      }

      misc {
        vrr = true
        # Swallowing
        enable_swallow = true
        swallow_regex = "foot"
      }

      decoration {
          rounding = 10
          blur = yes
          blur_size = 3
          blur_passes = 1
          blur_new_optimizations = on
          drop_shadow = yes
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
      }

      animations {
          enabled = yes
          bezier = myBezier, 0.05, 0.9, 0.1, 1.05
          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }

      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = yes # you probably want this
      }

      master {
          new_is_master = true
      }

      gestures {
          workspace_swipe = off
      }

      # Example windowrule v1
      # windowrule = float, ^(kitty)$
      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = SUPER

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $mainMod SHIFT, Q, killactive,
      bind = , Print, exec, screenshot
      bind = $mainMod, A, exec, foot ${getExe pulsemixer}
      bind = $mainMod, D, exec, rofi -show run
      bind = $mainMod, E, exec, foot aerc
      bind = $mainMod, F, fullscreen,
      bind = $mainMod, I, exec, foot ${getExe btop}
      bind = $mainMod, M, exit,
      bind = $mainMod, P, exec, emoji
      bind = $mainMod, R, exec, foot lf
      bind = $mainMod, X, exec, swaylock
      bind = $mainMod, RETURN, exec, foot
      bind = $mainMod, S, exec, search
      bind = $mainMod, V, togglefloating,
      bind = $mainMod, W, exec, firefox -p default
      bind = ALT SHIFT, F, fakefullscreen,
      # bind = $mainMod, J, togglesplit, # dwindle

      # Move focus with mainMod + arrow keys
      ${addToFile (
        map (key: "bind = $mainMod, ${key}, movefocus, l") ["h" "LEFT"]
      )}
      ${addToFile (
        map (key: "bind = $mainMod, ${key}, movefocus, r") ["l" "RIGHT"]
      )}
      ${addToFile (
        map (key: "bind = $mainMod, ${key}, movefocus, u") ["k" "UP"]
      )}
      ${addToFile (
        map (key: "bind = $mainMod, ${key}, movefocus, d") ["j" "DOWN"]
      )}

      # Switch workspaces with mainMod + [0-9]
      ${addToFile
        (forEach allWorkspaces
          (number: "bind = $mainMod, ${toString (
            if number == 10
            then 0
            else number
          )}, workspace, ${toString number}"))}

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      ${addToFile
        (forEach allWorkspaces
          (number: "bind = $mainMod SHIFT, ${toString (
            if number == 10
            then 0
            else number
          )}, movetoworkspace, ${toString number}"))}

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Window Rules
      ${genWinRule2 ["workspace 1" "fakefullscreen"]
        ["class:(org.remmina.Remmina)"]}
      ${genWinRule2 ["workspace 6" "tile"]
        ["class:^(Steam)" "title:^(Steam)"]}
      windowrulev2=workspace 9,class:^(Element)
      windowrulev2=maximize,class:^(Firefox),title:(Picture-in-Picture)
    '';
  };
}
