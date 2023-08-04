{ pkgs
, lib
, ...
}:
let
  inherit (lib) getExe;
  inherit (lib.lists) forEach range;
  inherit (builtins) concatStringsSep concatLists;
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
  addToFile = concatStringsSep "\n";
  assignWorkspaces = monitor: workspaces:
    addToFile (map (number: "workspace=${toString number},monitor:${monitor}")
      workspaces);
  genRule2 = rules: regexs:
    map (regex: "${addToFile (map (rule: "${rule},${regex}") rules)}") regexs;
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        "${leftMon},preferred,0x0,auto"
        "${rightMon},1920x1080@60,1920x0,1"
      ];
      general = {
        gaps_in = gaps;
        gaps_out = gaps * 2;
        border_size = 2;
        "col.active_border" = "rgba(E323BEEE) rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };
      exec-once = [
        "transmission-daemon"
        "${getExe foot} --title=newsboat ${getExe newsboat}"
        "beeper"
        "librewolf"
        "swww init"
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
        blur = true;
        blur_size = 3;
        blur_passes = 1;
        blur_new_optimizations = false;
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
        (map (str: "${mod}${str}") [
          " SHIFT, E, exec, emacsclient --create-frame"
          " SHIFT, Q, killactive,"
          " SHIFT, W, exec, ${getExe tor-browser-bundle-bin}"
          ", A, exec, ${termify pulsemixer}"
          ", D, exec, rofi -show run"
          ", E, exec, kitty aerc"
          ", F, fullscreen, 0"
          ", I, exec, ${termify btop}"
          ", M, fullscreen, 1"
          ", N, exec, ${getExe foot} --title=newsboat ${getExe newsboat}"
          ", P, exec, emoji"
          ", R, exec, ${termify lf}"
          ", RETURN, exec, ${getExe wezterm}"
          ", S, exec, search"
          ", T, exec, ${termify tremc}"
          ", V, togglefloating,"
          ", W, exec, librewolf"
          ", X, exec, swaylock"
          ", Z, exec,password-menu"
          ", mouse_down, workspace, e+1"
          ", mouse_up, workspace, e-1"
        ])
        (map (key: "${mod}, ${key}, movefocus, d") [ "j" "DOWN" ])
        (map (key: "${mod}, ${key}, movefocus, l") [ "h" "LEFT" ])
        (map (key: "${mod}, ${key}, movefocus, r") [ "l" "RIGHT" ])
        (map (key: "${mod}, ${key}, movefocus, u") [ "k" "UP" ])
        [
          ", Print, exec, screenshot"
          "ALT SHIFT, F, fakefullscreen,"
        ]
        (forEach allWorkspaces
          (number: ''
            bind = ${mod}, ${useRightNum number}, workspace, ${toString number}
            bind = ${mod} SHIFT, ${useRightNum number}, movetoworkspacesilent, ${toString number}''))
      ];
      bindm = [
        "${mod}, mouse:272, movewindow"
        "${mod}, mouse:273, resizewindow"
      ];
      windowrulev2 = concatLists [
        [
          "float,nofullscreen,class:firefox,title:^Firefox — Sharing Indicator$"
          "maximize,class:^(librewolf)$,title:Picture-in-Picture"
          "workspace 8 silent,class:^(foot|mpv)$,title:newsboat"
        ]
        (genRule2
          [ "workspace 1 silent" "fakefullscreen" ]
          [ "class:org.remmina.Remmina" ])
        (genRule2
          [ "workspace 6 silent" "tile" ]
          [ "class:^([Ss]team|.gamescope-wrapped)" ])
        (genRule2
          [ "dimaround" "float" "pin" ]
          [ "class:^(gcr-prompter|[Rr]ofi)" ])
        (genRule2
          [ "workspace 9 silent" ]
          [ "class:^(Ferdium|Beeper)" "title:^(aerc)" ])
      ];
    };
    extraConfig = ''
      # Window Rules
    '';
  };
}
