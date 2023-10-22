_: {
  imports = [
    ./graphical
    ./theme.nix
  ];
  xdg = {
    mimeApps = {
      enable = true;
    };
    userDirs.enable = true;
  };
}
