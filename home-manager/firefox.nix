{ ... }: {
    programs.firefox.enable = true;
    programs.firefox.profiles = {
        lucas = {
            # extensions = "";
	    search.default = "DuckDuckGo";
        };
    };
}
