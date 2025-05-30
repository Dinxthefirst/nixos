{
  programs.alacritty.settings = {
    window.dimensions = {
      lines = 3;
      columns = 200;
    };
    keyboard.bindings = [
      {
        key = "K";
        mods = "Control";
        chars = "\\u000c";
      }
    ];

    # font = {
    #   size = 16.0;
    #   normal = {
    #     family = "Fira Code";
    #     style = "Regular";
    #   };
    #   bold = {
    #     family = "Fira Code";
    #     style = "Bold";
    #   };
    #   italic = {
    #     family = "Fira Code";
    #     style = "Italic";
    #   };
    #   bold_italic = {
    #     family = "Fira Code";
    #     style = "Bold Italic";
    #   };
    # };

    # window = {
    #   opacity = 0.7;
    # };

    # colors = {
    #   primary = {
    #     background = "#000000";
    #     foreground = "#FFFFFF";
    #   };
    # };
  };
}
