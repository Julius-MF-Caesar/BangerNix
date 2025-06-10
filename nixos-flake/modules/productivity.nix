{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    neovim
    bitwarden
    libreoffice
    zathura
    joplin-desktop
    oh-my-zsh
    fzf-zsh
  ];
}
