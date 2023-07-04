{ pkgs, lib, ... }:
let
  terminal = "${lib.getExe pkgs.foot}";
in
{
  programs.qutebrowser = {
    enable = true;
    package = pkgs.qutebrowser-qt6;
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
      aw = "https://wiki.archlinux.org/?search={}";
      f = "https://flathub.org/apps/search/{}";
      gh = "github.com/search?q={}";
      nw = "https://nixos.wiki/index.php?search={}";
      pd = "https://www.protondb.com/search?q={}";
      ph = "https://www.phind.com/search?q={}&source=searchbox";
      w = "https://en.wikipedia.org/w/index.php?search={}";
    };
    quickmarks = {
      home-manager = "https://github.com/nix-community/home-manager";
      m = "https://reader.miniflux.app/";
      nixpkgs = "https://github.com/NixOS/nixpkgs";
      nvo = "https://pta2002.github.io/nixvim/";
      tdm = "twitch.tv/drmick";
      hw = "https://wiki.hyprland.org/";
    };
    settings = {
      editor.command = [ terminal "nvim" "{file}" ];
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
