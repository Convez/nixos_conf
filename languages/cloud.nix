{ config, pkgs, lib, ... }:
let
  convez = config.convez;
  vim-hashicorp-tools = pkgs.vimUtils.buildVimPlugin {
    name = "vim-hashicorp-tools";
    src = pkgs.fetchFromGitHub {
      owner = "hashivim";
      repo = "vim-hashicorp-tools";
      rev = "4a81618e15abe90448aa62284f71992135a98131";
      sha256 = "BFjlG6JI58vD9SCsigfiJCv/eA+uo9/vmy1S4K42Tfk=";
    };
  };
in
{
  packages = lib.optionals convez.coding.languages.cloud (with pkgs;[
    minikube
    kubectl
    kubelogin
    k9s
    azure-cli
    kubernetes-helm
    terraform
    buildpack
  ]);

  codeExtensions = lib.optionals convez.coding.languages.cloud (with pkgs.vscode-extensions;[
    ms-azuretools.vscode-docker
    ms-vscode-remote.remote-containers
    redhat.vscode-yaml
    ms-kubernetes-tools.vscode-kubernetes-tools
    hashicorp.terraform
  ]);

  codeSettings = lib.optionalAttrs convez.coding.languages.cloud {
  };

  vimPlugins = lib.optionals convez.coding.languages.cloud(with pkgs.vimPlugins;[
    coc-docker
    vim-helm
    vim-hashicorp-tools
  ]);
  
  vimSettings = ''
  '';
}