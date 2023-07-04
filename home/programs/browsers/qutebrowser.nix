_: {
  programs.qutebrowser = {
    enable = true;
    aliases = {};
    keyBindings = {
      prompt = {
        "<Ctrl-y>" = "prompt-yes";
      };
      normal = {"eu" = "edit-url";};
    };
    searchEngines = {
      aw = "https://wiki.archlinux.org/?search={}";
      gh = "github.com/search?q={}";
      nw = "https://nixos.wiki/index.php?search={}";
      p = "https://www.phind.com/search?q={}&source=searchbox";
    };
    quickmarks = {
      home-manager = "https://github.com/nix-community/home-manager";
      m = "https://reader.miniflux.app/";
      nixpkgs = "https://github.com/NixOS/nixpkgs";
      nvo = "https://pta2002.github.io/nixvim/";
      tdm = "twitch.tv/drmick";
    };
    settings = {
      editor.command = ["foot" "nvim" "{file}"];
      downloads.location.prompt = false;
    };
  };
}
