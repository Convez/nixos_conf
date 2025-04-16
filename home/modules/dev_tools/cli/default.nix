{pkgs, config, lib, ...}:
let
  cfg = config.myHome.cli;
  kubeTools = lib.optionals cfg.enableKubeTools (with pkgs; [
    kubectl
    kubelogin
    k9s
    kubernetes-helm
    helmfile
    terraform
  ]);
  miniK8s = lib.optionals cfg.enableMinikube (with pkgs; [
    minikube
  ]); 
  tfCli = lib.optionals cfg.enableTerraform (with pkgs; [
    terraform
  ]);
  azCli = lib.optionals cfg.enableAzCli (with pkgs; [
    azure-cli
  ]);
  paketoCli = lib.optionals cfg.enableBuildpack (with pkgs; [
    buildpack
  ]);
  toInstall = kubeTools ++ 
    miniK8s ++ 
    tfCli ++ 
    azCli ++ 
    paketoCli ; 
in
with lib;
{
options.myHome.cli = {
  enableKubeTools = mkEnableOption "Enable kube tools (kubectl, kubelogin, helm, etc.)"; 
  enableMinikube = mkEnableOption "Enable minikube";
  enableTerraform = mkEnableOption "Enable terraform";
  enableAzCli = mkEnableOption "Enable az cli";
  enableBuildpack = mkEnableOption "Enable buildpack";
};
config = {
  home.packages = toInstall;
};
}
