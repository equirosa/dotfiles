{ pkgs
, lib
, ...
}:
let
  inherit (lib) genAttrs;
  langList = [
    "bash"
    "elm"
    "javascript"
    "typescript"
    "jsx"
    "tsx"
    "lua"
    "nix"
    "rust"
  ];
  generatedLanguages = map (langName: { name = "${langName}"; auto-format = true; }) langList;
in
{
  programs.helix = {
    enable = true;
    languages = generatedLanguages;
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
