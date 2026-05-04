{ config, pkgs, lib, ... }:
let
  cfg = config.myHome.dev.nvim;

  # Helper to build a plugin not yet in nixpkgs
  pluginFromGitHub = { owner, repo, rev, hash }:
    pkgs.vimUtils.buildVimPlugin {
      pname = repo;
      version = rev;
      src = pkgs.fetchFromGitHub { inherit owner repo rev hash; };
    };

  vim-pink-moon = pluginFromGitHub {
    owner = "sts10";
    repo = "vim-pink-moon";
    rev = "master";
    hash = "sha256-7g8UPziVZYrYyywUOfCZM8Xjm7d3O2f1H5u4FlYpmuI=";
  };

  golf-vim = pluginFromGitHub {
    owner = "vuciv";
    repo = "golf";
    rev = "main";
    hash = "sha256-lCzt+7/uZ/vvWnvWPIqjtS3G3w3qOhI7vHdSQ9bvMKU=";
  };

in
with lib; {
  options.myHome.dev.nvim = {
    enable = mkEnableOption "Install and configure neovim";
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      defaultEditor = true;
      withPython3 = false;
      withRuby = false;

      initLua = builtins.concatStringsSep "\n" [
        (builtins.readFile ./config/base.lua)
        (builtins.readFile ./config/keymaps.lua)
        (builtins.readFile ./config/lsp.lua)
      ];

      plugins = with pkgs.vimPlugins; [
        # Telescope
        {
          plugin = telescope-nvim;
          type = "lua";
          config = builtins.readFile ./config/plugin/telescope.lua;
        }
        plenary-nvim

        # Treesitter — grammars provided by Nix, no runtime downloads
        # Neovim 0.12+ enables treesitter highlighting automatically
        (nvim-treesitter.withAllGrammars)
        # Note: treesitter playground is archived. Use built-in :InspectTree instead.

        # Git
        {
          plugin = vim-fugitive;
          type = "lua";
          config = builtins.readFile ./config/plugin/fugitive.lua;
        }

        # Undo tree
        {
          plugin = undotree;
          type = "lua";
          config = builtins.readFile ./config/plugin/undotree.lua;
        }

        # Auto pairs
        {
          plugin = nvim-autopairs;
          type = "lua";
          config = builtins.readFile ./config/plugin/autopairs.lua;
        }

        # Colorschemes
        {
          plugin = vim-pink-moon;
          type = "lua";
          config = builtins.readFile ./config/plugin/colors.lua;
        }
        neovim-ayu
        rose-pine

        # LSP
        nvim-lspconfig
        nvim-jdtls

        # Direnv integration
        direnv-vim

        # Fun
        vim-be-good
        golf-vim
      ];

      # Global LSP servers — always available
      extraPackages = with pkgs; [
        lua-language-server
        nixd
        bash-language-server
        fish-lsp
      ];
    };

    home.packages = with pkgs; [
      ripgrep # needed for telescope grep
      opencode
    ];
  };
}

