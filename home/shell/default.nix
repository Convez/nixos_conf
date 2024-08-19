{config, pkgs,...}:
let 
in {
  
  programs.zsh = {
    enable = true;
    enableCompletion = false;
    autosuggestion.enable = false;
    syntaxHighlighting.enable = true;
    
    initExtra = ''
      bindkey -v
      bindkey '^R' history-incremental-search-backward
      bindkey '^H' backward-kill-word
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
      bindkey              '^I'         menu-complete
      bindkey "$terminfo[kcbt]" reverse-menu-complete
      export JAVA_HOME="${config.convez.coding.languages.java.version}/lib/openjdk";
      source ${pkgs.azure-cli}/share/zsh/site-functions/_az;
      export RUST_SRC_PATH="${pkgs.rustPackages.rustPlatform.rustcSrc}/library";
      export PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig"
    '';

    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      update = "sudo nixos-rebuild switch";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "marlonrichert/zsh-autocomplete";}
        { name = "zsh-users/zsh-syntax-highlighting";}
        { name = "zsh-users/zsh-history-substring-search";}
        { name = "romkatv/powerlevel10k"; tags = [ "as:theme" "depth:1" ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
      ];
    };
    plugins = [
      {
        name = "powerlevel10k-config";
        src = ./p10k-config;
        file = "p10k.zsh";
      }
    ];
  };
}