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
      nw = "https://nixos.wiki/index.php?search={}";
    };
  };
}
