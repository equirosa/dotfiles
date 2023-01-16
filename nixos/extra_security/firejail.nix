{ pkgs
, lib
, ...
}: {
  programs.firejail =
    let
      inherit (lib) genAttrs getExe;
      wrappedPackageNames = [ "signal-desktop" ];
    in
    {
      enable = true;
      wrappedBinaries = genAttrs wrappedPackageNames (packageName: {
        executable = "${getExe pkgs.${packageName}}";
        profile = "${pkgs.firejail}/etc/firejail/${packageName}.profile";
      });
    };
}
