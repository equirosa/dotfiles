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
in
{
  # Produces an expression that can be passed to `home.file` or
  # `xdg.configFile` that symlinks all dirs in `sourceDir`
  # to the relative string `targetDir`.
  # Both arguments must be strings.
  # `sourceDir` is relative to `./.`.
  # symlinkDirContents = sourceDir: targetDir:
  #   mapAttrs'
  #     (
  #       name: _:
  #         nameValuePair (targetDir + "/${name}") { source = config.lib.file.mkOutOfStoreSymlink ("${configDir}/" + sourceDir + "/${name}"); }
  #     )
  #     (readDir (./. + "/${sourceDir}"));
  inherit filesIn nixFilesIn;
}
