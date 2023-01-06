{ pkgs
, lib
, ...
}:
let
  inherit (lib) genAttrs;
  languageList = [ "elm" "lua" "nix" ];
  generateLanguages = langList: map (langName: { name = "${langName}"; auto-format = true; }) langList;
in
{
  programs.helix = {
    enable = true;
    languages = generateLanguages languageList;
    settings = {
      theme = "onedark";
      editor = {
        line-number = "relative";
        mouse = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
      keys = {
        normal = {
          space = {
            space = "file_picker";
            w = ":w";
            q = ":q";
          };
          Z = {
            Q = ":q!";
            Z = ":wq";
          };
        };
      };
    };
  };
}
