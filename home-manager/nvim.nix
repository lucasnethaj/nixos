{ pkgs, ... }: {
    programs.neovim = {
        enable = true;
    };

    programs.neovim.plugins = with pkgs.vimPlugins; [
        nvim-treesitter
        nvim-treesitter-parsers.d
    ];

    # Extra Deps
    home.packages = with pkgs; [
        unzip
        gcc
	    cargo
    ];
}
