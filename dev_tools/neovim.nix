{ config, pkgs, languages, ... }:
let
 cfg = config.convez.coding;
in
{
  programs.neovim = {
    enable = cfg.ides.vim;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      coc-nvim
      vim-airline
      vim-airline-themes
      vim-fugitive
      vim-plug
      nerdtree
    ];

    extraConfig = ''
      " Specify a directory for plugins
      call plug#begin('~/.vim/plugged')

      " List of plugins
      Plug 'neoclide/coc.nvim', {'branch': 'release'}
      Plug 'preservim/nerdtree'
      Plug 'tpope/vim-fugitive'
      Plug 'vim-airline/vim-airline'
      Plug 'vim-airline/vim-airline-themes'

      " Initialize plugin system
      call plug#end()

      " General settings
      syntax on
      set number
      set relativenumber

      " Airline configuration
      let g:airline#extensions#tabline#enabled = 1
      let g:airline#extensions#tabline#fnamemod = ':t'
      let g:airline#extensions#tabline#buffer_nr_show = 1
      let g:airline_powerline_fonts = 1

      " NERDTree configuration
      map <C-n> :NERDTreeToggle<CR>
      let NERDTreeShowHidden=1

      " CoC (Conqueror of Completion) configuration
      let g:coc_global_extensions = ['coc-json', 'coc-pyright', 'coc-tsserver']

      " Key mappings for CoC
      inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
      inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
      nnoremap <silent> gd <Plug>(coc-definition)
      nnoremap <silent> gr <Plug>(coc-references)

      " Auto commands for file types
      autocmd FileType python setlocal shiftwidth=4 tabstop=4
      autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
    '';
  };
}