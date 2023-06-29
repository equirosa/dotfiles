_: {
  programs.qutebrowser = {
    enable = true;
    aliases = {};
    keyBindings = {
      prompt = {
        "<Ctrl-y>" = "prompt-yes";
      };
    };
    searchEngines = {
      aw = "https://wiki.archlinux.org/?search={}";
      gh = "github.com/search?q={}";
      nw = "https://nixos.wiki/index.php?search={}";
      p = "https://www.phind.com/search?q={}&source=searchbox";
    };
  };
}
