{ lib, ... }:
let
  inherit (builtins) readDir;
  inherit (lib) filterAttrs mapAttrsToList hasSuffix;
  filesIn =
    { folder
    , ext ? null
    ,
    }:
    mapAttrsToList
      (name: folder + ("/" + name))
      (filterAttrs
        (key: value: value == "regular" && hasSuffix ".${ext}" key)
        (readDir folder));
in
{
  inherit filesIn;
  nixFilesIn = folder: filesIn {
    inherit folder;
    ext = "nix";
  };
  shellFilesIn = folder: filesIn {
    inherit folder;
    ext = "sh";
  };
}
