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
          terminal: Some("kitty"),
        )
      '';
      "websearch.ron".text = ''
        Custom(
          name: "Nixpkgs Unstable",
          url: "search.nixos.org/packages?channel=unstable&query={}",
        )
        engines: [DuckDuckGo,Nixpkgs Unstable]
      '';
    };
  };
}
