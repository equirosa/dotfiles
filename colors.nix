let
  gruvbox = {
    foreground = "ebdbb2";
    background = "1d2021";
    regular = {
      black = "000000";
      red = "cc241d";
      green = "98971a";
      yellow = "d79921";
      blue = "458488";
      magenta = "b16286";
      cyan = "689d6a";
      white = "928374";
    };
    bright = {
      black = "928374";
      red = "fb4934";
      green = "b8bb26";
      yellow = "fabd2f";
      blue = "83a598";
      magenta = "d3869b";
      cyan = "8ec07c";
      white = "a89984";
    };
  };
in {
  opacity = "0.8";
  selected = gruvbox;
  ansi = {
    normal = "00";
    bold = "01";
    red = "31";
    green = "32";
    yellow = "33";
    blue = "34";
    pink = "35";
    teal = "36";
    grey = "37";
    white = "38";
  };
}
