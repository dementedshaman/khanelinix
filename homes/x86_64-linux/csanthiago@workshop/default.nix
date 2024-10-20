{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkForce;
  inherit (lib.${namespace}) enabled disabled;
in
{
  khanelinix = {
    user = {
      enable = true;
      inherit (config.snowfallorg.user) name;
    };

    programs = {
      graphical = {
        editors = {
          vscode = mkForce disabled;
        };
      };

      terminal = {
        emulators = {
          wezterm = mkForce disabled;
        };

        tools = {
          git = {
            enable = true;
          };

          ssh = enabled;
        };
      };
    };

    system = {
      xdg = enabled;
    };

    suites = {
      business = enabled;
      common = enabled;
      development = {
        enable = true;
        dockerEnable = true;
        kubernetesEnable = true;
      };
    };

    theme.catppuccin = enabled;
  };

  sops.secrets.kubernetes = {
    path = "${config.home.homeDirectory}/.kube/config";
  };

  home.stateVersion = "23.11";
}
