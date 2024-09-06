{ config, pkgs, ... }: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    profiles = {
      lucas = {
        # extensions = "";
        # search.default = "DuckDuckGo";
      };
    };
  };
}
