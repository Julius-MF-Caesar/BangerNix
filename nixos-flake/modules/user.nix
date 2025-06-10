{ config, pkgs, ... }: {
  users.users.sean = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
