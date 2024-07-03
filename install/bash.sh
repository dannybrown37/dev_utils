#!/usr/bin/bash -i

apt_packages=(
    bash-completion
    bat
    curl
    fzf
    git
    httpie
    jq
    make
    man-db
    neofetch
    pipx
    rename
    ripgrep
    shellcheck
    unzip
    wget
    zip
    zoxide
)

sudo apt update
sudo apt upgrade

if [[ "${WSL_DISTRO_NAME}" = 'kali-linux' ]]; then
    apt_packages+=(eza)
else
    apt_packages+=(exa)
fi

for package in "${apt_packages[@]}"; do
    if ! dpkg -s "${package}" >/dev/null 2>&1; then
        sudo apt install -y "${package}"
    fi
done

##
## Install programs with wget such as Google Chrome
##

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -f
rm google-chrome-stable_current_amd64.deb

###
### Create symlinks for various config/dotfiles
###

ln -s ~/projects/dotfiles/config/.gitconfig ~/.gitconfig
echo "Symlinked .gitconfig"

mv ~/.bashrc ~/.bashrc.og.bak
ln -s ~/projects/dotfiles/config/.bashrc ~/.bashrc
echo "Symlinked .bashrc"

ln -s ~/projects/dotfiles/config/.ruff.toml ~/.ruff.toml
echo "Symlinked .ruff.toml"

ln -s ~/projects/dotfiles/pass ~/.password-store
echo "Symlinked pass to ~/.password-store"
