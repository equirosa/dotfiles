{ pkgs, ... }: {
  programs.helix = {
    enable = true;
    languages = [
      { name = "elm"; auto-format = true; }
      { name = "nix"; auto-format = true; }
    ];
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
