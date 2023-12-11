{
  services.espanso = {
    enable = true;
    configs = {
      default = {
        show_notifications = false;
      };
    };
    matches = {
      base.matches = [
        {
          trigger = ":now";
          replace = "It's {{currentdate}} {{currenttime}}";
        }
      ];
      globalvars.globalvars = [
        {
          name = "currentdate";
          type = "date";
          params = { format = "%d/%m/%Y"; };
        }
        {
          name = "currenttime";
          type = "date";
          params = { format = "%R"; };
        }
      ];
    };
  };
}
