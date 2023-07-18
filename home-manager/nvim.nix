{ pkgs, lib, ... }: {
    programs.neovim = {
        enable = true;
        defaultEditor = true;
        extraConfig = lib.fileContents ./nvim;
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
