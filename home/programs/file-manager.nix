{ pkgs
, ...
}:
let
  exiftool = "${pkgs.exiftool}/bin/exiftool";
in
{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    settings = {
      manager.show_hidden = false;
      opener = {
        image = [
          { exec = ''xdg-open "$@"''; display_name = "Open"; }
          {
            exec = ''${exiftool} "$1"; echo "Press enter to exit"; read'';
            block = true;
            display_name = "Show EXIF";
          }
        ];
      };
    };
    theme = { };
  };
}
