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
        {
          regex = ":hi(?P<person>.*)\\.";
          replace = "Hi {{person}}!";
        }
        {
          trigger = ":uber";
          replace = "Hola! Ahorita viene un pedido mio, para que lo dejen pasar, por favor 😁";
        }
      ];
      global_vars.global_vars = [
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
