# configuration.nix
{ config, lib, pkgs, ... }: {

  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 2048; # Use 2048MiB memory.
      cores = 3;
      graphics = false;
    };
  };

  services.openssh = {
    enable = true;
    settings = { 
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "yes";
    };
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCJoCzYwbuhnW/CkDqJCER+vhxNzIrEroS1EonT40wyYYjsv5yVU0CD2y2/FBhF9zE9CMf32vnbAmgbsq2oBdqrit9EOtOGm1P9j23P4vF1+VQbx1f3eyNm2kWN0ybTehx/gHNl9VFs3FqoqNbuO39ivJfJQJDq6L/jGDgw8svPbyC99jsVClmF/RBWb8fYXyM4yTCcvz/nzmTHuTIZdYKa2alOzO43jo7nR5FWhj+y5PHyaGpboVeXXft3BL63EvuRKRaRwykGz9ILI85vHSOr2tTJ96H+10V35PmuHvsRyJzXD0xo4e2RkXKAhPvuYN1KG256OCWgdjk99mzFo02QxNEibprNLh9dU/o2mPxUAp8OHofK9IFqF/m3+xk78zP0W7DaHwsjuCxC+x9U/QFMRV550c0rAFrwh9/p0Ln6GXDVspUCU9tSnjcxV4yjuJRf0GUfOZOtm9Chh04L7yesbdOq54icEUWVnfhqQ+vhMBSitEAKGeTvrW8OmWyYbUk= root" # content of authorized_keys file
  ];

  networking.firewall.allowedTCPPorts = [ 22 ];

  environment.systemPackages = with pkgs; [
    htop
    curl
    bpftrace
  ];

  system.stateVersion = "23.05";
}
