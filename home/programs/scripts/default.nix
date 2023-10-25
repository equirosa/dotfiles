{ pkgs, ... }: {
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "regen";
      runtimeInputs = [ pkgs.nvd ];
      text = fileContents ./regen.sh;
    })
  ];
}
