{ ... }: {

    programs.firefox.profiles = {
        lucas = {
            extensions = "";
	    search.default = "DuckDuckGo";
        };
    };
}
