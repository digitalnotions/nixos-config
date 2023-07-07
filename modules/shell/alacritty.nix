#
# Alacritty terminal configuration
#

{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        font = {
          normal.family = "FiraCode Nerd Font";
          bold.family = "FiraCode Nerd Font";
          italic.family = "FiraCode Nerd Font";
          size = 10;
        };
        window = {
          opacity = 0.90;
          dimensions = {
            columns = 100;
            lines = 30;
          };
        };
        key_bindings = [
          {
            key = "N";
            mods = "Control";
            action = "SpawnNewInstance";
          }
          {
            key = "Q";
            mods = "Control";
            action = "Quit";
          }
          {
            key = "Y";
            mods = "Control";
            action = "Paste";
          }
          {
            key = "W";
            mods = "Control";
            action = "Copy";
          }
          {
            key = "NumpadAdd";
            mods = "Control|Shift";
            action = "IncreaseFontSize";
          }
          {
            key = "NumpadSubtract";
            mods = "Control|Shift";
            action = "DecreaseFontSize";
          }
        ];
        url = {
          launcher = "open";
          modifieres = "Shift";
        };
      };
    };
  };

  home = {
    sessionVariables = {
      TERM = "alacritty";
    };
  };

}
