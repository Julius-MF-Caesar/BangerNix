# /etc/nixos/configuration.nix
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "BangerNix";
  time.timeZone = "America/Los_Angeles";

  users.users.sean = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    pkgs.gnome.gnome-session
    pkgs.gnome.gnome-tweaks
    pkgs.vim
    pkgs.neovim
    gpkgs.it
    pkgs.steam
    pkgs.discord
    pkgs.bitwarden-desktop
    pkgs.librewolf
    pkgs.htop-vim
    pkgs.kitty
  ];

  # Enable GNOME and make it default (force Wayland for GDM)
  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true; # Ensures GDM runs on Wayland
    };
    desktopManager.gnome.enable = true;
  };

  # Help apps (like Electron, Chrome, etc.) use Wayland if possible
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # zsh as default shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Kitty as default terminal (set with GNOME Tweaks)
  programs.kitty.enable = true;

  # Set Librewolf as default browser
  programs.librewolf.enable = true;
  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "librewolf.desktop" ];
    "x-scheme-handler/http" = [ "librewolf.desktop" ];
    "x-scheme-handler/https" = [ "librewolf.desktop" ];
    "x-scheme-handler/about" = [ "librewolf.desktop" ];
    "x-scheme-handler/unknown" = [ "librewolf.desktop" ];
  };

  # Allow proprietary packages for Steam/Discord
  nixpkgs.config.allowUnfree = true;
}

