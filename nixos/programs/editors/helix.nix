{ pkgs, ... }: {
  programs.helix = {
    enable = true;
    languages = [
      { name = "elm"; auto-format = true; }
    ];
    settings = {
      theme = "base16";
      lsp = { display-messages = true; };
      keys = {
        normal = {
          space = {
            space = "file_picker";
            w = ":w";
            q = ":q";
          };
        };
      };
    };
  };
}
