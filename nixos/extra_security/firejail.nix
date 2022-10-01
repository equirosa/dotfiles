{ pkgs
, lib
, ...
}: {
  programs = {
    firejail =
      let
        inherit (lib) genAttrs;
        wrappedPackageNames = [ "signal-desktop" ];
      in
      {
        enable = true;
        wrappedBinaries = genAttrs wrappedPackageNames (packageName: {
          executable = "${lib.getBin pkgs.${packageName}}/bin/${packageName}";
          profile = "${pkgs.firejail}/etc/firejail/${packageName}.profile";
        });
      };
  };
}
