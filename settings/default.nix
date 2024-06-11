{lib, ...}:

let
  tools = import ../lib {inherit lib;};
  inherit (tools) mkEnDef;
in{
  options.convez = {
    coding = {
      enable = mkEnDef "Enable coding goodies" false;
      ides = {
        vim =           mkEnDef "Install and configure NeoVim" false;
        code =          mkEnDef "Install and configure VSCodium" false;
      };
      languages = {
        c =           mkEnDef "Enable Clang tooling" false;
        cloud =       mkEnDef "Enable Cloud tooling" false;
        c_sharp =     mkEnDef "Enable C# tooling" false;
        go =          mkEnDef "Enable Go tooling" false;
        haskell =     mkEnDef "Enable Haskell tooling" false;
        java =        mkEnDef "Enable Java tooling" false;
        typescript =  mkEnDef "Enable Typescript tooling" false;
        json =        mkEnDef "Enable JSON tooling" false;
        kotlin =      mkEnDef "Enable Kotlin tooling" false;
        lua =         mkEnDef "Enable LUA tooling" false;
        nix =         mkEnDef "Enable Nix tooling" false;
        purescript =  mkEnDef "Enable Purescript tooling" false;
        racket =      mkEnDef "Enable racket tooling" false;
        rust =        mkEnDef "Enable Rust tooling" false;
        scripting =   mkEnDef "Enable scripting tooling" false;
        terraform =   mkEnDef "Enable Terraform tooling" false;
        yaml =        mkEnDef "Enable YAML tooling" false;
        typst =       mkEnDef "Enable Typst tooling" false;
      };
    };
  };
}
