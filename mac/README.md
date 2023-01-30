

# Install homebrew
https://brew.sh

Install required coreutils needed by ls command (with .dircolors config)

	brew install coreutils

Install critical stuff

	brew install git
	brew install git-extras
	brew install git-lfg

Run this to finish git lfg install

	git lfs install
	git lfs install --system

# Install Sublime
https://www.sublimetext.com

Create soft link so sublime text always works with `sub`

	ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/sub

# Install On-my-zsh
https://ohmyz.sh

COPY the following files from `vanillia/mac` to your home directory

	.zshrc
	.gitconfig
	.dircolors
	.king-zsh-theme

## Install zsh plugins

	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

	git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install critical stuff

## Languages

	brew install go
	brew install node
	brew install python3
	brew install lua
	brew install ruby

## Common tools

	brew install unrar
	brew install p7zip
	brew install xz
	brew install ack
	brew install tree
	brew install nmap
	brew install wget
	brew install cmake
	brew install ninja

## Proto stuff
	brew install protobuf
	brew install protoc-gen-go
	brew install protoc-gen-go-grpc
	brew install swift-protobuf
	brew install swiftformat
	brew install swiftlint

## Editors

	brew install vim
	brew install emacs








