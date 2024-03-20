{ config, pkgs, ... }: {
    programs.firefox = {
        enable = true;
        package = pkgs.firefox-wayland;
        profiles = {
            lucas = {
# extensions = "";
                # search.default = "DuckDuckGo";
            };

            # extensions = with config.nur.repos.rycee.firefox-addons; [
            #     darkreader
            #     ublock-origin
            # ];

        };
    };
}
