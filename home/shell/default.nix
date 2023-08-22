{ pkgs
, lib
, colors
, ...
}:
let
  inherit (lib) genAttrs;
in
{
  imports = [ ./fish.nix ./nushell.nix ];
  home.shellAliases = import ./aliases.nix { inherit pkgs lib; } // import ./abbreviations.nix;
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      config = {
        global = {
          bash_path = "${pkgs.bash}/bin/bash";
          load_dotenv = true;
          strict_env = true;
        };
        whitelist.prefix = [ "/home/kiri/projects" ];
      };
    };
    gpg = {
      enable = true;
      settings.default-key = "03678E9642EB6D9E99974ACFB77F36C3F12720B4";
    };
    keychain = {
      enable = true;
      agents = [ "ssh" "gpg" ];
      keys = [ "id_ed25519" "B77F36C3F12720B4" ];
      extraFlags = [ "--quiet" ];
    };
    less.enable = true;
    ssh.enable = true;
    tealdeer = {
      enable = true;
      settings = {
        display = {
          compact = false;
          use_pager = false;
        };
        updates.auto_update = true;
      };
    };
    bat = {
      enable = true;
      config = {
        pager = "${pkgs.less}/bin/less -FR";
        theme = "gruvbox-dark";
      };
    };
    dircolors = {
      enable = true;
      settings = with colors.ansi; let
        dataFiles = [ "csv" "json" "toml" "yaml" ];
        docFiles = [ "md" "org" "docx" "odt" ];
        scriptFiles = [ "sh" "bash" "awk" ];
        mediaFiles = [ "avif" "mkv" "mp4" "webm" "webp" ];
        pdf = [ "pdf" ];
        extAttrs = extList: color: (genAttrs (map (ext: ".${ext}") extList)
          (_: "${bold};${color}"));
      in
      { OTHER_WRITABLE = "30;46"; }
      // (extAttrs dataFiles yellow)
      // (extAttrs docFiles teal)
      // (extAttrs mediaFiles pink)
      // (extAttrs pdf red)
      // (extAttrs scriptFiles green)
      ;
    };
    lsd = {
      enable = true;
      settings = { date = "relative"; };
    };
    exa = {
      enable = true;
      git = true;
      icons = true;
      extraOptions = [ "--header" ];
    };
    fzf =
      let
        fileCommand = "${pkgs.ripgrep}/bin/rg --files";
      in
      {
        enable = true;
        changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d";
        changeDirWidgetOptions = [ "--preview '${pkgs.lsd}/bin/lsd -1 {}'" ];
        defaultCommand = "${fileCommand}";
        defaultOptions = [ "--height 100%" "--border" ];
        fileWidgetCommand = "${fileCommand}";
        fileWidgetOptions = [ "--preview '${pkgs.ctpv}/bin/ctpv {}'" ];
      };
    navi = { enable = true; };
    starship = {
      enable = true;
      settings = {
        git_commit.commit_hash_length = 4;
        git_metrics.disabled = false;
        git_status = {
          ahead = "⇡ $count ";
          behind = "⇣ $count ";
          conflicted = "= $count ";
          deleted = "✘ $count ";
          diverged = "⇕ $count ";
          modified = "! $count ";
          renamed = "» $count ";
          staged = "+ $count ";
          stashed = "$ $count ";
          untracked = "? $count ";
        };
        golang.symbol = " ";
        hostname.ssh_only = true;
        lua.symbol = " ";
        nix_shell.symbol = " ";
        python.symbol = " ";
        rust.symbol = " ";
        sudo.disabled = false;
      };
    };
    zoxide.enable = true;
  };
  services = {
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 34560000;
      maxCacheTtl = 34560000;
      enableScDaemon = false;
      enableSshSupport = true;
      pinentryFlavor = "gnome3";
      extraConfig = ''
        allow-emacs-pinentry
        allow-loopback-pinentry
      '';
    };
    syncthing.enable = true;
    udiskie.enable = true;
  };
}
