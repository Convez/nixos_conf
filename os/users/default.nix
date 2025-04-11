{ config, lib, ... }:
with lib;
with lib.types;
let
  cfg = config.myConf.users;
  userType = submodule {
    options = {
      userName = mkOption {
        type = str;
        description = "Name of the user to create";
      };
      shell = mkOption {
        type = package;
        description = "Default shell of the user to create";
      };
      canSudo = mkOption {
        type = bool;
        default = false;
        description = "Whether the user can use sudo";
      };
      extraGroups = mkOption {
        type = listOf str;
        default = [ ];
        description = "Extra groups to add the user to";
      };
    };
  };
  toCreate = map (user: {
    name = user.userName;
    value = {
      isNormalUser = true;
      description = user.userName;
      shell = user.shell;
      extraGroups = (if user.canSudo then [ "wheel" "networkmanager" ] else [ ])
        ++ user.extraGroups;
    };
  }) cfg.userList;
  toCreateAttr = listToAttrs toCreate;
in {
  options.myConf.users = {
    create = mkEnableOption "Create users";
    userList = mkOption {
      type = listOf userType;
      description = "List of users to create";
    };
  };
  config = mkIf cfg.create {
    users.users = toCreateAttr;
    # TODO: Move this to a separate module allowing multiple shell installation
    programs.zsh.enable = true;
  };
}
