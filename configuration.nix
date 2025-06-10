{ config, pkgs, ... }:

{
  # Host and user configuration
  networking.hostName = "BangerNix";
  users.users.sean = {
    isNormalUser = true;
    home = "/home/sean";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "audio" "video" ];
  };

  # Enable Zsh with Oh‑My‑Zsh and useful plugins
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" "fzf" ];
    };
    initExtra = ''
      source ${pkgs.fzf}/share/fzf.zsh
    '';
  };

  # Desktop environment
  services.xserver.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  # Package overrides for gaming tools
  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [ mangohud gamemode gamescope ];
    };
  };

  # System-wide packages
  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    vim neovim git steam gamescope gamemode mangohud lutris bottles
    discord bitwarden librewolf htop kitty spotify zathura
    minecraft oh-my-zsh fzf-zsh yazi vscode
  ];

  # Enable and configure GNOME Tweaks (via gnomeExtensions)
  services.gnome3.tweaks.enable = true;

  # Optional: Xbox controllers (if needed)
  hardware.pulseaudio.support32Bit = true;

  # Enable GTK and font support
  fonts.fontconfig.enable = true;

  # Allow Steam Proton and Flatpak (for bottles, lutris, discord etc.)
  programs.flatpak.enable = true;

  # Basic enable of common services
  system.stateVersion = "23.05";
}
