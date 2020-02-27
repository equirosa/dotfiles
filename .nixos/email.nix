{ config, pkgs, ... }: {
  home-manager.users.eduardo = { pkgs, ... }: {
    accounts.email = {
      main = {
        address = "eduardo@eduardoquiros.com";
        gpg = {
          encryptByDefault = true;
          key = "03678E9642EB6D9E99974ACFB77F36C3F12720B4";
          signByDefault = true;
        };
        imap = {
          host = "c1560850.ferozo.com";

        };
        realName = "Eduardo Quirós";
        smtp = { host = "c1560850.ferozo.com"; };
        userName = "eduardo@eduardoquiros.com";
      };
    };
  };
}
