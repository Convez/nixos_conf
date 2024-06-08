{ ... }:
{
  
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable OpenSSH services
  services.openssh = {
    enable = true;
    ports = [ 2222 ];
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
    };
  };
  
  #Enable docker
  virtualisation.docker.enable =  true;
}