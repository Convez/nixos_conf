{ config, pkgs, lib, ... }: 
let
cfg = config.myHome.shells.zsh;
hasTmux = config.myHome.shells.tmux.enable;
useTmux = if hasTmux then ''
			if [ "$TMUX" = "" ]; then tmux; fi
'' else "";
baseConfig = ''
      bindkey -v
      bindkey '^R' history-incremental-search-backward
      bindkey '^H' backward-kill-word
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
      export PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig"
'';
autoCompleteConf = if cfg.enableAutocomplete then ''
      bindkey              '^I'         menu-complete
      bindkey "$terminfo[kcbt]" reverse-menu-complete
      source ${pkgs.azure-cli}/share/zsh/site-functions/_az;
'' else "";
concatLines = lib.concatStringsSep "\n" cfg.extraInitConfig; 
totalInitConfig = ''
			${useTmux}
      ${baseConfig}
      ${autoCompleteConf}
      ${concatLines}
'';
autoCompletePlugins = if cfg.enableAutocomplete then [
  { name = "marlonrichert/zsh-autocomplete"; }
  { name = "zsh-users/zsh-syntax-highlighting"; }
  { name = "zsh-users/zsh-history-substring-search"; }
] else [];
in
with lib;
{

options.myHome.shells.zsh = {
  enable = mkEnableOption "Enable Zsh configuration";
  enableAutocomplete = mkEnableOption "Enable Zsh autocomplete";	
  extraInitConfig = mkOption {
    type = types. listOf types.str;
    default = [];
    description = "Extra configuration to be added to the zsh init file";
  };
};
config = mkIf cfg.enable {
  programs.zsh = {
    enable = cfg.enable;
    enableCompletion = cfg.enableAutocomplete;
    autosuggestion.enable = cfg.enableAutocomplete;
    syntaxHighlighting.enable = true;
    initContent = totalInitConfig;

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
        {
          name = "romkatv/powerlevel10k";
          tags = [ "as:theme" "depth:1" ];
        } # Installations with additional options. For the list of options, please refer to Zplug README.
      ]++ autoCompletePlugins;
    };
    plugins = [{
      name = "powerlevel10k-config";
      src = ./p10k-config;
      file = "p10k.zsh";
    }];
  };
};
}
