{ config, pkgs, ... }:
let
 cfg = config.convez.coding;
in
{
  home.sessionVariables.EDITOR = if cfg.ides.vim then "nvim" else "nano"; 
  programs.neovim = {
    enable = cfg.ides.vim;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      vim-plug
      vim-nix
      coc-nvim
      nerdtree
      copilot-vim
      vim-airline
      vim-airline-themes
      vim-fugitive
      nerdtree
    ];
    extraConfig = ''
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
    '';
  };
}