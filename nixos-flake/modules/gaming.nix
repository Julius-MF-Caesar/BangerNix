{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    steam
    lutris
    mangohud
    gamemode
    prismlauncher
  ];

  programs.steam.enable = true;
}
