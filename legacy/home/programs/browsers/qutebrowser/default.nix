{ pkgs, lib, ... }:
{
  programs.qutebrowser = {
    enable = true;
    extraConfig = lib.strings.fileContents ./config.py;
    aliases = { };
    keyBindings = {
      prompt = {
        "<Ctrl-y>" = "prompt-yes";
      };
      normal = {
        am = "spawn --userscript add-to-miniflux";
        aw = "spawn --userscript add-to-wallabag";
        cs = "config-source";
        eu = "edit-url";
      };
    };
    searchEngines = {
      aw = "wiki.archlinux.org/?search={}";
      d = "duckduckgo.com?q={}";
      f = "flathub.org/apps/search/{}";
      gh = "github.com/search?q={}";
      nw = "nixos.wiki/index.php?search={}";
      pd = "www.protondb.com/search?q={}";
      ph = "www.phind.com/search?q={}&source=searchbox";
      w = "en.wikipedia.org/w/index.php?search={}";
    };
    quickmarks = {
      cal = "calendar.google.com";
      hm = "github.com/nix-community/home-manager";
      hw = "wiki.hyprland.org/";
      m = "reader.miniflux.app/";
      nixpkgs = "github.com/NixOS/nixpkgs";
      nvo = "pta2002.github.io/nixvim/";
      tdm = "https://safetwitch.drgns.space/drmick";
    };
    settings = {
      content.fullscreen.window = true;
      editor.command = [ "emacsclient" "-c" "{file}" ];
      downloads.location.prompt = false;
    };
  };
  xdg.dataFile = {
    "qutebrowser/userscripts/add-to-wallabag" = {
      executable = true;
      source = pkgs.writeShellScript "add-to-wallabag" ''
        echo "open -t https://wallabag.nixnet.services/bookmarklet?url="$QUTE_URL >> $QUTE_FIFO
      '';
    };
    "qutebrowser/userscripts/add-to-miniflux" = {
      executable = true;
      source = pkgs.writeShellScript "add-to-miniflux" ''
        echo "open -t https://reader.miniflux.app/bookmarklet?uri="$QUTE_URL >> $QUTE_FIFO
      '';
    };
  };
}
