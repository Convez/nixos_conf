{pkgs, lib, ...}:

let
  tools = import ../lib {inherit lib;};
  inherit (tools) mkEnDef mkEnStrDef mkEnPkgDef;
in{
  options.convez = {
    coding = {
      enable = mkEnDef "Enable coding goodies" false;
      ides = {
        vim =           mkEnDef "Install and configure NeoVim" false;
        code =          mkEnDef "Install and configure VSCodium" false;
      };
      languages = {
        #c =           mkEnDef "Enable Clang tooling" false;
        cloud =       mkEnDef "Enable Cloud tooling" false;
        #c_sharp =     mkEnDef "Enable C# tooling" false;
        #go =          mkEnDef "Enable Go tooling" false;
        #haskell =     mkEnDef "Enable Haskell tooling" false;
        java = {
          enable =    mkEnDef "Enable Java tooling" false;
          version =   mkEnPkgDef "Java version (ex. 8, 11, 17, 21)" pkgs.jdk; 
        };        
        typescript =  mkEnDef "Enable Typescript tooling" false;
        #json =        mkEnDef "Enable JSON tooling" false;
        #kotlin =      mkEnDef "Enable Kotlin tooling" false;
        #lua =         mkEnDef "Enable LUA tooling" false;
        nix =         mkEnDef "Enable Nix tooling" false;
        #purescript =  mkEnDef "Enable Purescript tooling" false;
        #racket =      mkEnDef "Enable racket tooling" false;
        rust =        mkEnDef "Enable Rust tooling" false;
        #scripting =   mkEnDef "Enable scripting tooling" false;
        #yaml =        mkEnDef "Enable YAML tooling" false;
        #typst =       mkEnDef "Enable Typst tooling" false;
      };
      maven = {
        settings = mkEnStrDef "Maven settings.xml file to target" "default";
      };
    };
  };
}
