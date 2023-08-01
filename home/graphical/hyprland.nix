{ pkgs
, lib
, ...
}:
let
  inherit (lib) getExe;
  inherit (lib.lists) forEach range;
  inherit (builtins) concatStringsSep;
  inherit
    (pkgs)
    btop
    foot
    lf
    newsboat
    pulsemixer
    tor-browser-bundle-bin
    tremc
    wezterm
    ;
  gaps = 2;
  mod = "SUPER";
  leftMon = "DP-1";
  rightMon = "HDMI-A-1";
  leftWorkspaces = range 1 6;
  rightWorkspaces = range 7 10;
  allWorkspaces = leftWorkspaces ++ rightWorkspaces;
  useRightNum = num: toString (
    if num == 10
    then 0
    else num
  );
  defaultTerm = getExe wezterm;
  termify = program: "${defaultTerm} -e ${getExe program}";
  execOnce = addToFile (map (command: "exec-once=${command}") [
    "transmission-daemon"
    "${getExe foot} --title=newsboat ${getExe newsboat}"
    "beeper"
    "librewolf"
    "swww init"
  ]);
  addToFile = concatStringsSep "\n";
  assignWorkspaces = monitor: workspaces:
    addToFile (map (number: "workspace=${toString number},monitor:${monitor}")
      workspaces);
  genRule2 = rules: regexs:
    addToFile (map (regex: "${addToFile (map (rule: "windowrulev2=${rule},${regex}") rules)}") regexs);
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    recommendedEnvironment = true;
    extraConfig = ''
      monitor=${leftMon},preferred,0x0,auto
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
        enable_swallow=true
        swallow_regex=^(foot)
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
          pseudotile = yes
          preserve_split = yes # you probably want this
      }

      bind = ${mod} SHIFT, Q, killactive,
      bind = ${mod}, A, exec, ${termify pulsemixer}
      bind = ${mod}, D, exec, rofi -show run
      bind = ${mod}, E, exec, kitty aerc
      bind = ${mod} SHIFT, E, exec, emacsclient --create-frame
      bind = ${mod}, F, fullscreen, 0
      bind = ${mod}, I, exec, ${termify btop}
      bind = ${mod}, M, fullscreen, 1
      bind = ${mod}, N, exec, ${getExe foot} --title=newsboat ${getExe newsboat}
      bind = ${mod}, P, exec, emoji
      bind = ${mod}, R, exec, ${termify lf}
      bind = ${mod}, RETURN, exec, foot
      bind = ${mod}, S, exec, search
      bind = ${mod}, T, exec, ${termify tremc}
      bind = ${mod}, V, togglefloating,
      bind = ${mod}, W, exec, librewolf
      bind = ${mod} SHIFT, W, exec, ${getExe tor-browser-bundle-bin}
      bind = ${mod}, X, exec, swaylock
      bind = ${mod}, Z, exec,password-menu
      bind = , Print, exec, screenshot
      bind = ALT SHIFT, F, fakefullscreen,

      # Move focus with ${mod} + arrow keys
      ${addToFile (
        map (key: "bind = ${mod}, ${key}, movefocus, l") ["h" "LEFT"]
      )}
      ${addToFile (
        map (key: "bind = ${mod}, ${key}, movefocus, r") ["l" "RIGHT"]
      )}
      ${addToFile (
        map (key: "bind = ${mod}, ${key}, movefocus, u") ["k" "UP"]
      )}
      ${addToFile (
        map (key: "bind = ${mod}, ${key}, movefocus, d") ["j" "DOWN"]
      )}

      # Switch workspaces with ${mod} + [0-9]
      ${addToFile
        (forEach allWorkspaces
          (number: ''
            bind = ${mod}, ${useRightNum number}, workspace, ${toString number}
            bind = ${mod} SHIFT, ${useRightNum number}, movetoworkspacesilent, ${toString number}''))}

      # Scroll through existing workspaces with ${mod} + scroll
      bind = ${mod}, mouse_down, workspace, e+1
      bind = ${mod}, mouse_up, workspace, e-1

      # Move/resize windows with ${mod} + LMB/RMB and dragging
      bindm = ${mod}, mouse:272, movewindow
      bindm = ${mod}, mouse:273, resizewindow

      # Window Rules
      ${genRule2 ["workspace 1 silent" "fakefullscreen"]
        ["class:org.remmina.Remmina"]}
      ${genRule2 ["workspace 6 silent" "tile"]
        ["class:^([Ss]team|.gamescope-wrapped)"]}
      ${genRule2 ["dimaround" "float" "pin"]
        ["class:^(gcr-prompter|[Rr]ofi)"]}
      ${genRule2 ["workspace 9 silent"] ["class:^(Ferdium|Beeper)" "title:^(aerc)"]}
      windowrulev2=float,nofullscreen,class:firefox,title:^Firefox — Sharing Indicator$
      windowrulev2=maximize,class:^(librewolf)$,title:Picture-in-Picture
      windowrulev2=workspace 8 silent,class:^(foot|mpv)$,title:newsboat

      ${execOnce}
    '';
  };
}
