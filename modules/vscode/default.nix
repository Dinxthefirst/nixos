{
  pkgs,
  lib,
  config,
  specialArgs,
  ...
}:
with lib; let
  cfg = config.modules.vscode;
  user = specialArgs.user;
in {
  options = {
    modules.vscode.enable = mkEnableOption "vscode";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user} = {
      programs.vscode = {
        enable = true;
        profiles.default = {
          extensions = with pkgs.vscode-extensions; [
            kamadorueda.alejandra
            bbenoist.nix
            ms-vsliveshare.vsliveshare
            esbenp.prettier-vscode
            ocamllabs.ocaml-platform
            dracula-theme.theme-dracula
            mkhl.direnv
            ms-python.vscode-pylance
          ];
          userSettings = {
            "[html]" = {
              "editor.tabSize" = 2;
              "editor.defaultFormatter" = "ocaml-ocamlformat";
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
            "[scala]" = {
              "editor.tabSize" = 2;
              "editor.defaultFormatter" = "scalameta.metals";
            };
            "[coq]" = {
              "editor.tabSize" = 2;
            };
            "editor.formatOnSave" = true;
            "editor.fontFamily" = "'Fira Code'";
            "editor.fontLigatures" = true;
            "editor.minimap.enabled" = false;
            "editor.detectIndentation" = false;
            "workbench.startupEditor" = "none";
            "workbench.colorTheme" = "Dracula Theme";
            "editor.fontSize" = 16;
            "editor.rulers" = [80];
            "files.watcherExclude" = {
              "**/.bloop" = true;
              "**/.metals" = true;
            };
            "zig.zls.enabled" = "on";
            "window.autodetectColorScheme" = true;
            "workbench.preferredDarkColorTheme" = "Dracula Theme";
            "workbench.preferredLightColorTheme" = "Solarized Light";
          };
        };
      };
    };
  };
}
