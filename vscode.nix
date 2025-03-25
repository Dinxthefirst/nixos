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
      ];
      userSettings = {
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
        "editor"."minimap"."enabled" = false;
        "editor"."detectIndentation" = false;
        "workbench"."startupEditor" = "none";
      };
    };
  };
}
