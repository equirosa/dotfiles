{ pkgs, lib, ... }:
let
  inherit (lib) getExe genAttrs recursiveUpdate;
in
{
  imports = [ ./fish.nix ];
  home-manager.users.kiri = {
    home.shellAliases = import ./aliases.nix { inherit pkgs lib; };
    programs = {
      bat = {
        enable = true;
        config = {
          pager = "${getExe pkgs.less} -FR";
          theme = "TwoDark";
        };
      };
      dircolors = {
        enable = true;
        settings =
          let
            bold = "01";
            red = "31";
            green = "32";
            yellow = "33";
            blue = "34";
            pink = "35";
            teal = "36";
            grey = "37";
            dataFiles = [ "csv" "json" "toml" "yaml" ];
            mediaFiles = [ "mkv" "mp4" "webm" "webp" ];
            docFiles = [ "md" "org" "docx" "odt" ];
            pdf = [ "pdf" ];
            extAttrs = extList: color: (genAttrs (map (ext: ".${ext}") extList) (ext: "${bold};${color}"));
          in
          recursiveUpdate
            {
              OTHER_WRITABLE = "30;46";
              ".sh" = "${bold};${green}";
            }
            (recursiveUpdate
              (extAttrs dataFiles yellow)
              (recursiveUpdate
                (extAttrs docFiles teal)
                (recursiveUpdate
                  (extAttrs mediaFiles pink)
                  (extAttrs pdf red))));
      };
      lsd = {
        enable = true;
        enableAliases = true;
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
          golang.symbol = " ";
          hostname.ssh_only = true;
          lua.symbol = " ";
          python.symbol = " ";
          rust.symbol = " ";
          sudo.disabled = false;
        };
      };
      zoxide.enable = true;
    };
  };
}
