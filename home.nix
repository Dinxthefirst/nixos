{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "toft";
  home.homeDirectory = "/home/toft";

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  home.packages = [
    inputs.zen-browser.packages."x86_64-linux".default
    pkgs.home-manager
  ];

  nixpkgs.config.allowUnfree = true;

  programs.git = {
    enable = true;
    userName = "Oliver Toft";
    userEmail = "olivertoftk@live.dk";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        kamadorueda.alejandra
        bbenoist.nix
        ms-vsliveshare.vsliveshare
        james-yu.latex-workshop
        esbenp.prettier-vscode
        ocamllabs.ocaml-platform
        # azemoh.one-monokai
        dracula-theme.theme-dracula
      ];
      userSettings = {
        "editor"."tabSize" = 4;
        "[html, nix, ocaml, json, css, javascript]" = {
          "editor"."tabSize" = 2;
        };
        "latex-workshop"."latex"."outDir" = "/tmp/latex-build";
        "editor"."formatOnSave" = true;
        "files"."autoSave" = "onFocusChange";
        "[jsonc]" = {
          "editor"."defaultFormatter" = "esbenp.prettier-vscode";
        };
        "latex-workshop"."formatting"."latex" = "latexindent";
        "[ocaml]" = {
          "editor"."defaultFormatter" = "ocaml-ocamlformat";
        };
        "editor"."minimap.enabled" = false;
        "editor"."fontFamily" = "'Fira Code'";
        "editor"."fontLigatures" = true;
        "workbench"."colorTheme" = "Dracula Theme";
      };
    };
  };
}
