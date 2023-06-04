{ pkgs, ... }: {
    programs.neovim = {
        enable = true;
    };

    # Extra Deps
    home.packages = with pkgs; [
        unzip
        gcc
	    cargo
    ];
}
