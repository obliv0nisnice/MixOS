{
  lib,
  pkgs,
  inputs,
  ...
}:
# https://nix-community.github.io/nixvim/NeovimOptions/index.html
let
  # cfg = osConfig.custom.nixvimPlugins; maybe mal in sheet einbauen ob mans braucht?args
  cfg = true;
  args = {inherit lib pkgs;};

  importFile = file: let
    config = import file;
  in
    if builtins.isFunction config
    then config args
    else config;
  configs = map importFile ([
      ./config.nix
    ]
    ++ lib.optionals cfg [
      ./auto-pairs.nix
      ./autosave.nix
      ./blankline.nix
      ./barbar.nix
      ./cmp.nix
      ./fidget.nix
      ./refactoring.nix
      ./git.nix
      ./lightline.nix
      ./lsp.nix
      ./images.nix
      ./none-ls.nix
      ./nvim-tree.nix
      ./telescope.nix
      ./toggleterm.nix
      ./treesitter.nix
      ./trouble.nix
      ./which_key.nix
      ./wilder.nix
      ./typst-preview.nix
      ./markdown.nix
      ./hop.nix
      ./colorizer.nix
      ./surround.nix
    ]);
  merged =
    builtins.foldl' (acc: elem: lib.recursiveUpdate acc elem) {} configs;
in {
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];
  home.sessionVariables = {EDITOR = "nvim";};
  programs.nixvim = merged;
}
