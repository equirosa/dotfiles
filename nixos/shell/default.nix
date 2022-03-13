{pkgs, ...}: {
  imports = [./fish.nix];
  home-manager.users.kiri = {
    programs = {
      bat = {
        enable = true;
        config = {pager = "${pkgs.less}/bin/less -FR";};
      };
      fzf = {
        enable = true;
        changeDirWidgetCommand = "${pkgs.fd}/bin/fd -uu --type d";
        changeDirWidgetOptions = ["--preview '${pkgs.lsd}/bin/lsd -1 {}'"];
        defaultCommand = "${pkgs.fd}/bin/fd -uu --type f";
        fileWidgetCommand = "${pkgs.fd}/bin/fd -uu --type f";
        fileWidgetOptions = ["--preview '${pkgs.pistol}/bin/pistol {}'"];
      };
      starship = {
        enable = true;
        settings = {
          git_commit = {
            commit_hash_length = 4;
            tag_symbol = " ";
          };
          golang.symbol = " ";
          hostname.ssh_only = true;
          lua.symbol = " ";
          python.symbol = " ";
          rust.symbol = " ";
        };
      };
      zoxide.enable = true;
    };
  };
}
