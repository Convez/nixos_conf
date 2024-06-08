{ ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.convez = {
    isNormalUser = true;
    description = "convez";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
}