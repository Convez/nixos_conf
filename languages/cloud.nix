{ config, pkgs, lib, ... }:
let
  convez = config.convez;
in
{
  packages = lib.optionals convez.coding.languages.cloud (with pkgs;[
    minikube
    kubectl
    k9s
    azure-cli
    kubernetes-helm
  ]);

  codeExtensions = lib.optionals convez.coding.languages.cloud (with pkgs.vscode-extensions;[
    ms-azuretools.vscode-docker
    ms-vscode-remote.remote-containers
    redhat.vscode-yaml
    ms-kubernetes-tools.vscode-kubernetes-tools
  ]);

  codeSettings = lib.optionalAttrs convez.coding.languages.cloud {
  };

  vimPlugins = lib.optionals convez.coding.languages.cloud(with pkgs.vimPlugins;[
    coc-docker
    vim-helm
  ]);
  
  vimSettings = ''
  '';
}