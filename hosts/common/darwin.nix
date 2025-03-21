{
  pkgs,
  settings,
  ...
}: {
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "${settings.name}";
    autoMigrate = true;
  };

  users.users.${settings.name} = {
    name = "${settings.name}";
    home = "/Users/${settings.name}";
  };

  homebrew = {
    enable = true;
    casks = [
      "anki"
      "brave-browser"
      "calibre"
      "kicad"
      "ghostty"
      "google-chrome"
      "spotify"
      "zed"
    ];
    onActivation.cleanup = "zap";
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    defaults = {
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        ApplePressAndHoldEnabled = false;
        AppleShowAllExtensions = true;
        KeyRepeat = 2;
        NSAutomaticWindowAnimationsEnabled = false;
        NSDocumentSaveNewDocumentsToCloud = false;
        PMPrintingExpandedStateForPrint = true;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      # swapLeftCtrlAndFn = true;
      # Remap §± to ~
      userKeyMapping = [
        {
          HIDKeyboardModifierMappingDst = 30064771125;
          HIDKeyboardModifierMappingSrc = 30064771172;
        }
      ];
    };
  };

  environment.variables = {
    FLAKE_PATH = "${settings.flakePath}";
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.optimise.automatic = true;
  system.stateVersion = 6;
  nixpkgs.config.allowUnfree = true;
}
