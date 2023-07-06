_: {
  programs.librewolf = {
    enable = true;
    settings = {
      "identity.fxaccounts.enabled" = true;
      "privacy.resistFingerprinting.letterboxing" = true;
    };
  };
}
