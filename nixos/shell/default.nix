{ pkgs, lib, ... }:
let
  inherit (lib) getExe;
in
{
  imports = [ ./bash.nix ./fish.nix ];
  home-manager.users.kiri = {
    home.shellAliases = import ./aliases.nix { inherit pkgs; };
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
            inherit (lib) genAttrs recursiveUpdate;
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
      starship = {
        enable = true;
        settings = {
          git_commit = {
            commit_hash_length = 4;
            tag_symbol = " ";
          };
          golang.symbol = " ";
          hostname.ssh_only = true;
          lua.symbol = " ";
          python.symbol = " ";
          rust.symbol = " ";
        };
      };
      zoxide.enable = true;
    };
  };
}
