{pkgs, ...}: {
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
        dracula-theme.theme-dracula
        mkhl.direnv
        ms-python.vscode-pylance
      ];
      userSettings = {
        "[html, nix, ocaml, json, css, javascript, jsonc, typescript]" = {
          "editor.tabSize" = 2;
        };
        "latex-workshop.latex.outDir" = "/tmp/latex-build";
        "editor.formatOnSave" = true;
        "files.autoSave" = "onFocusChange";
        "[jsonc, typescript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "latex-workshop.formatting.latex" = "latexindent";
        "[ocaml]" = {
          "editor.defaultFormatter" = "ocaml-ocamlformat";
        };
        "editor.fontFamily" = "'Fira Code'";
        "editor.fontLigatures" = true;
        "editor.minimap.enabled" = false;
        "editor.detectIndentation" = false;
        "workbench.startupEditor" = "none";
        "workbench.colorTheme" = "Dracula Theme";
        "editor.fontSize" = 16;
        "editor.rulers" = 80;
      };
    };
  };
}
