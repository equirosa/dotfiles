{
  imports = [
    ./default.nix
    ./graphical
    ./theme.nix
    ./shell/linux.nix
    ./programs/linux.nix
  ];
  xdg = {
    mimeApps = {
      enable = true;
    };
    userDirs.enable = true;
  };
}
