#!/usr/bin/env bash

set_config(){
	key="$1"
	value="$2"
	file="$3"

	value_set=$(awk '/'$key'/ {print $0}' $file)

	if [ "$key=$value" = "$value_set" ]
	then
		return
	fi

	if [ -z "$value_set" ]
	then
		echo "$key=$value" | sudo tee -a "$file"
	else
		sudo sed -i "s/$value_set/$key=$value/g" $file
	fi
}

# Setup dnf
set_config 'fastestmirror' True /etc/dnf/dnf.conf
set_config 'max_parallel_downloads' 5 /etc/dnf/dnf.conf
set_config 'keepcache' True /etc/dnf/dnf.conf

# Setup Time/date/lang
echo 'LANG=en_US.UTF-8
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME=en_GB.UTF-8
LC_COLLATE="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_PAPER=en_GB.UTF-8
LC_NAME="en_US.UTF-8"
LC_ADDRESS="en_US.UTF-8"
LC_TELEPHONE="en_US.UTF-8"
LC_MEASUREMENT=en_GB.UTF-8
LC_IDENTIFICATION="en_US.UTF-8"
LC_ALL= ' | sudo tee /etc/locale.conf

# Install git Flow:
sudo dnf --assumeyes copr enable elegos/gitflow
sudo dnf --assumeyes install gitflow git

## Git Settings:
git config --global alias.st "status -s"
git config --global alias.uncommit "reset --soft HEAD^"
git config --global alias.history "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# Taken from: https://rpmfusion.org/Configuration
# Setup non-free repositories:
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Appstream metadata:
sudo dnf groupupdate core

# Multimedia post-install
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate sound-and-video

# File Transfer Bluetooth
sudo dnf install -y bluez-obexd

# Install VLC
dnf install vlc
#dnf install python-vlc #(optional)

## Install mdp
git clone https://github.com/visit1985/mdp.git
(cd mdp; sudo make; sudo make install)
rm -rf mdp

## Intall Docker
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker
pip install docker-compose

# Install Gnome Tweaks & and more.
sudo yum --assumeyes install gnome-tweaks
flatpak install --assumeyes flathub com.mattjakeman.ExtensionManager
flatpak install --assumeyes flathub com.github.liferooter.textpieces
flatpak install --assumeyes flathub com.discordapp.Discord
flatpak install --assumeyes flathub com.github.marktext.marktext # Marktext
# Flatseal  com.github.tchx84.Flatseal
# Color picker nl.hjdskes.gcolor3

# # Install Game stuff
# sudo yum --assumeyes install steam steam-devices lutris

# Install utils
sudo dnf groupinstall "Development Tools" "Development Libraries"
sudo dnf install glibc-devel.i686, libstdc++-devel.i686
sudo yum --assumeyes install exa bat rmlint

# Install rust
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
#sudo yum --assumeyes install rust.x86_64 cargo


# Install Python Stuff
sudo yum --assumeyes install python3-pip
pip3 install ipython

# Install Codium
sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo
sudo yum --assumeyes install codium

# install Others
sudo yum --assumeyes install nmap unzip unrar vim-enhanced

# # Install KDE-Connect CLI.
# sudo yum --assumeyes install kde-connect

# Setting up Gnome Window
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize:'

# General Gnome Settings
gsettings set org.gnome.desktop.interface enable-hot-corners false

# Terminal Shortcut!
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "Launch Kitty"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "kitty"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "<Ctrl><Alt>t"



# "https://extensions.gnome.org/extension/1319/gsconnect/"
# "https://extensions.gnome.org/extension/3960/transparent-top-bar-adjustable-transparency/"
# "https://extensions.gnome.org/extension/2890/tray-icons-reloaded/"
# "https://extensions.gnome.org/extension/4405/replace-activities-text/"
