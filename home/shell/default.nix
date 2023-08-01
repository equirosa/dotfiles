{ pkgs
, lib
, colors
, ...
}:
let
  inherit (lib) getExe genAttrs;
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
          bash_path = "${getExe pkgs.bash}";
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
        pager = "${getExe pkgs.less} -FR";
        theme = "gruvbox-dark";
      };
    };
    dircolors = {
      enable = true;
      settings = with colors.ansi; let
        dataFiles = [ "csv" "json" "toml" "yaml" ];
        mediaFiles = [ "avif" "mkv" "mp4" "webm" "webp" ];
        docFiles = [ "md" "org" "docx" "odt" ];
        pdf = [ "pdf" ];
        extAttrs = extList: color: (genAttrs (map (ext: ".${ext}") extList)
          (_: "${bold};${color}"));
      in
      {
        OTHER_WRITABLE = "30;46";
        ".sh" = "${bold};${green}";
      }
      // (extAttrs dataFiles yellow)
      // (extAttrs docFiles teal)
      // (extAttrs mediaFiles pink)
      // (extAttrs pdf red);
    };
    lsd = {
      enable = true;
      settings = { date = "relative"; };
    };
    fzf =
      let
        fileCommand = "${getExe pkgs.ripgrep} --files";
      in
      {
        enable = true;
        changeDirWidgetCommand = "${getExe pkgs.fd} --type d";
        changeDirWidgetOptions = [ "--preview '${getExe pkgs.lsd} -1 {}'" ];
        defaultCommand = "${fileCommand}";
        defaultOptions = [ "--height 100%" "--border" ];
        fileWidgetCommand = "${fileCommand}";
        fileWidgetOptions = [ "--preview '${getExe pkgs.pistol} {}'" ];
      };
    navi = { enable = true; };
    starship = {
      enable = true;
      settings = {
        git_commit.commit_hash_length = 4;
        git_metrics.disabled = false;
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
