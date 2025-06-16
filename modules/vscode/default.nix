{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.vscode;
in {
  options = {
    modules.vscode.enable = mkEnableOption "vscode";
  };

  config = mkIf cfg.enable {
    nixpkgs.config.allowUnfree = true;
    home-manager.users.toft = {
      nixpkgs.config.allowUnfree = true;
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
            "[html]" = {
              "editor.tabSize" = 2;
            };
            "[nix]" = {
              "editor.tabSize" = 2;
            };
            "[ocaml]" = {
              "editor.tabSize" = 2;
              "editor.defaultFormatter" = "ocaml-ocamlformat";
            };
            "[json]" = {
              "editor.tabSize" = 2;
            };
            "[jsonc]" = {
              "editor.tabSize" = 2;
              "editor.defaultFormatter" = "esbenp.prettier-vscode";
            };
            "[css]" = {
              "editor.tabSize" = 2;
            };
            "[javascript]" = {
              "editor.tabSize" = 2;
            };
            "[typescript]" = {
              "editor.tabSize" = 2;
              "editor.defaultFormatter" = "esbenp.prettier-vscode";
            };
            "[svelte]" = {
              "editor.tabSize" = 2;
            };
            "latex-workshop.latex.outDir" = "/tmp/latex-build";
            "editor.formatOnSave" = true;
            "files.autoSave" = "onFocusChange";
            "latex-workshop.formatting.latex" = "latexindent";
            "editor.fontFamily" = "'Fira Code'";
            "editor.fontLigatures" = true;
            "editor.minimap.enabled" = false;
            "editor.detectIndentation" = false;
            "workbench.startupEditor" = "none";
            "workbench.colorTheme" = "Dracula Theme";
            "editor.fontSize" = 16;
            "editor.rulers" = [80];
          };
        };
      };
    };
  };
}
