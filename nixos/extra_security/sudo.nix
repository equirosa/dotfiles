{ config, ... }: {
  security.sudo = {
    enable = true;
    execWheelOnly = true;
  };
}
