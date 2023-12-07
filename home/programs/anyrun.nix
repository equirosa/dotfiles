{ inputs, pkgs, ... }: {
  programs.anyrun = {
    enable = true;
    config = {
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
        rink
        websearch
        shell
        symbols
      ];
      width = { fraction = 0.3; };
      x = { fraction = 0.5; };
      y = { fraction = 0.5; };
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = false;
      closeOnClick = false;
      showResultsImmediately = false;
      maxEntries = null;
    };
    extraCss = ''
      .some_class {
        background: red;
      }
    '';

    extraConfigFiles = {
      "applications.ron".text = ''
        Config(
          desktop_actions: true,
          max_entries: 5,
          terminal: Some("kitty"),
        )
      '';
      "websearch.ron".text = ''
        Config(
          prefix: "?",
          engines: [
            DuckDuckGo,
            Custom( name: "Github", url: "github.com/search?q={}",),
            Custom( name: "Flathub", url: "flathub.org/apps/search?q={}",),
            Custom( name: "Nixos Wiki", url: "nixos.wiki/index.php?search={}",),
            Custom( name: "Nixos Packages", url: "search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}",),
            Custom( name: "Nixos Options", url: "search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}",),
            Custom( name: "ProtonDB", url: "protondb.com/search?q={}",),
            Custom( name: "YouTube", url: "youtube.com/results?search_query={}",),
          ]
        )
      '';
    };
  };
}
