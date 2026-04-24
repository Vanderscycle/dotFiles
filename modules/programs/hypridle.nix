{ ... }:
{
  steppe.program._.hypridle = {
    homeManager =
      { pkgs, ... }:
      {
        home = {
          packages = with pkgs; [
            brightnessctl
          ];
        };
        services.hypridle = {
          enable = true;
          settings = {
            general = {
              after_sleep_cmd = "hyprctl dispatch dpms on";
              # ignore_dbus_inhibit = false;
            };

            listener = [
              {
                timeout = 600;
                on-timeout = "brightnessctl set 10%"; # Requires brightnessctl package
                on-resume = "brightnessctl set 100%";
              }
              {

                timeout = 900;
                on-timeout = "systemctl suspend";
              }
            ];
          };
        };
      };
  };
}
