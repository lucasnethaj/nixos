{ pkgs, lib, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    # extraConfig = lib.fileContents ./nvim;
  };

  programs.neovim.plugins = with pkgs.vimPlugins; [
     pkgs.vimPlugins.nvim-treesitter
    (nvim-treesitter.withPlugins (p: [
        p.c
        p.d
    ]))
  ];

  # Extra Deps
  home.packages = with pkgs; [
    unzip
    gcc
    cargo
  ];
}
