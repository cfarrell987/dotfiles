#!/bin/bash
echo -e "Installing inital dependancies!\n"
if command -v zsh &> /dev/null && command -v git &> /dev/null && command -v wget &> /dev/null; then
    echo -e "ZSH and Git are already installed\n"
else
    if sudo apt install -y zsh git wget || sudo pacman -S zsh git wget || sudo dnf install -y zsh git wget || sudo yum install -y zsh git wget || sudo brew install git zsh wget || pkg install git zsh wget ; then
        echo -e "zsh wget and git Installed\n"
    else
        echo -e "Please install the following packages first, then try again: zsh git wget \n" && exit
    fi
fi

if mv -n ~/.zshrc ~/.zshrc-backup-$(date +"%Y-%m-%d"); then # backup .zshrc
    echo -e "Backed up the current .zshrc to .zshrc-backup-date\n"
fi

echo -e "Installing oh-my-zsh\n"
if [ -d ~/.oh-my-zsh ]; then
	echo -e "oh-my-zsh is already installed\n"
	git -C ~/.oh-my-zsh remote set-url origin https://github.com/ohmyzsh/ohmyzsh.git
else
	git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
fi

cp .zshrc ~/

echo -e "Installing additional plugins\n"
if [ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
	echo -e "zsh-syntax-highlighting is already installed!\n"
else
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

if [ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
	echo -e "zsh-autosuggestions is already installed!\n"
else
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [ -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]; then
	echo -e "powerlevel10k is already installed!\n"
else
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
sh ./install.sh
cd ..
rm -rf fonts

cp .p10k.zsh ~/

source ~/.zshrc