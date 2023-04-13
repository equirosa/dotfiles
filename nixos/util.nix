{ pkgs
, lib
,
}:
let
  inherit (builtins) readDir;
  filesIn = { folder, ext ? null }:
    lib.mapAttrsToList
      (name: value: folder + ("/" + name))
      (lib.filterAttrs
        (key: value: value == "regular" && lib.hasSuffix ".${ext}" key)
        (builtins.readDir folder));
  nixFilesIn = folder: filesIn { inherit folder; ext = "nix"; };
  shellFilesIn = folder: filesIn { inherit folder; ext = "sh"; };
in
{ inherit filesIn nixFilesIn shellFilesIn; }
