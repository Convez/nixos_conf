{ config, pkgs, lib, languages, ... }:
let
 cfg = config.convez.coding;

  baseConfig = ''
    " open NERDTree automatically
      autocmd StdinReadPre * let s:std_in=1
      autocmd VimEnter * NERDTree

      let g:NERDTreeGitStatusWithFlags = 1
      "let g:WebDevIconsUnicodeDecorateFolderNodes = 1
      "let g:NERDTreeGitStatusNodeColorization = 1
      "let g:NERDTreeColorMapCustom = {
          "\ "Staged"    : "#0ee375",  
          "\ "Modified"  : "#d9bf91",  
          "\ "Renamed"   : "#51C9FC",  
          "\ "Untracked" : "#FCE77C",  
          "\ "Unmerged"  : "#FC51E6",  
          "\ "Dirty"     : "#FFBD61",  
          "\ "Clean"     : "#87939A",   
          "\ "Ignored"   : "#808080"   
          "\ }                         


      let g:NERDTreeIgnore = ['^node_modules$']

      " NERDTree split navigation
      
      map <C-up> <C-w><up>
      map <C-down> <C-w><down>
      map <C-left> <C-w><left>
      map <C-right> <C-w><right>
      
      " CoC configuration
      nmap <silent> gd <Plug>(coc-definition)
      nmap <silent> gy <Plug>(coc-type-definition)
      nmap <silent> gr <Plug>(coc-references)

      nmap <silent> [g <Plug>(coc-diagnostic-prev)
      nmap <silent> ]g <Plug>(coc-diagnostic-next)
      nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>

      nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>

      nmap <leader>do <Plug>(coc-codeaction)

      nmap <leader>rn <Plug>(coc-rename)

      " Configure Airline theme
      set laststatus=2
      let g:airline#extensions#tabline#enabled = 1
      let g:airline_powerline_fonts = 1
      let g:airline_statusline_ontop=0
      let g:airline_theme='ayu_light'
      let g:airline#extensions#tabline#formatter = 'default'
      " Configure buffer navigation
      nnoremap <M-Right> :bn<cr>
      nnoremap <M-Left> :bp<cr>
      nnoremap <c-x> :bp \|bd #<cr>
  '';

in
{
  home.sessionVariables.EDITOR = if cfg.ides.vim then "nvim" else "nano"; 
  programs.neovim = {
    enable = cfg.ides.vim;
    viAlias = true;
    vimAlias = true;

    plugins = (with pkgs.vimPlugins; [
      vim-plug
      coc-nvim
      nerdtree
      copilot-vim # Don´t forget to run :Copilot setup
      vim-airline
      vim-airline-themes
      vim-fugitive
      nerdtree
    ]) ++ 
    languages.vimPlugins
    ;
    withNodeJs = true;
    extraConfig = lib.strings.concatStringsSep "\n" [
      baseConfig
      languages.vimSettings
    ];
    
  };
}
