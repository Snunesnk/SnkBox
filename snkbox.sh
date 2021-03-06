#!/usr/bin/env bash

# Automated deployment of automated media server (insn't it beautiful ?)
# During the deployment process, you can choose between a local installation,
# and remote installation with reverse proxy to your own domain name.
# you will be asked to make several choices. If you don't know the answer -> go for
# the defaut choice.
# You will be asked for several cretidentials too, please make sure you've prepared them
# Everything will be kept locally

#Font color / format
normal=$(tput sgr0)
bold=$(tput bold)
red=$(tput setaf 1)
green=$(tput setaf 2)


# Determine if the script is launched with init, deploy or stop

# Fonction to print usage if user used an invalid option / no option
printUsage()
{
	echo "Usage:"
	echo "./snkbox.sh setup"
	echo "./snkbox.sh deploy"
	echo ""
	echo "I need to do a proper usage print when I'll have some time"
}


#Function to install package with apt
InstallAptPack() {
	for bin in $@
	do
		#Check if a file would be executed when calling the executable, and check that it's
		#an existing pass
		dpkg -s $bin > /dev/null 2>&1
		if [ $? -ne 0 ];
		then
			echo "${bin} not installed, installing it ..."
			sudo apt install $bin
		
			#Check if everything went well
			if [ $? -eq 0 ]
			then
				echo "${bin} installed successfully !" #Maybe I can add little coloration to this
			else
				echo "Intallation for ${bold}${bin}${normal} failed ..."
				echo "Try to fix the error or install ${bin} manually, then you may relaunch the script."
				exit 1
			fi
		else
			echo "${bin} already installed, skip installation."
		fi
	done
}


#This function will get all setup for you.
#It will download all, add all repo, setup everything properly
#True magic
SetupDocker()
{
	echo "Let's setup your docker environment!"

	echo ""
	echo "${bold}--------------- Setting up docker environment ---------------${normal}"
	echo ""

	echo "Removing old docker versions (if any) ..."
	sudo apt remove docker docker-engine docker.io containerd runc
	echo "Done."

	echo "Updating ..."
	sudo apt update
	echo "Done."

	echo "Instaling everything needed."
	InstallAptPack "apt-transport-https" \
		"ca-certificates" \
		"curl" \
		"gnupg-agent" \
		"software-properties-common"
	echo "Done."

	echo "Adding Docker's official GPG key ..."
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	echo "Done."

	echo "Setting up stable repository ..."
	if ! grep -q "^deb*https://download.docker.com/linux/ubuntu" /etc/apt/sources.list /etc/apt/sources.list.d/*
	then
		sudo add-apt-repository \
			"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
			$(lsb_release -cs) \
			stable"
		echo "Done."
	else
		echo "Repository already set-up, skip."
	fi

	echo "Updating repo ..."
	sudo apt update
	echo "Done."

	echo "Installing docker engine ..."
	InstallAptPack "docker-ce" "docker-ce-cli" "containerd.io"
	echo "Done."

	echo "Testing docker installation ..."
	sudo systemctl status docker > /dev/null 2>&1
	if [ $? -ne 0 ]
	then
		echo "${red}Docker installation failed ...${normal}"
		exit
	else
		echo "${green}Docker is successfully set-up !${normal}"
	fi

	echo "Adding current user to sudo group for docker commands ..."
	sudo usermod -aG docker ${USER}
	echo "Done."

	echo ""
	#check if user already have docker completion or not
	if [ ! -e /etc/bash_completion.d/docker-compose ]
	then
		echo "Do you want to install Docker command-line completion for bash?"
		echo "Note: For zsh oh-my-zsh completion, add \"docker\" and \"docker-compose\" to your plugins in ~/.zshrc."
		echo "Ex: \"plugins=(... docker docker-compose)\""
		echo "Add it for bash? [Y/N] (default: N):"
		read
		if [ $REPLY == "y" ] || [ $REPLY == "yes" ] || [ $REPLY == "Y" ] || [ $REPLY == "YES" ]
		then
			sudo curl -L \
				https://raw.githubusercontent.com/docker/compose/1.27.4/contrib/completion/bash/docker-compose \
				-o /etc/bash_completion.d/docker-compose
			echo "Done."
		fi
	fi

	echo ""
	echo "${green}Congratulation! Everything is properly set-up${normal}"
}

#Let's find what the user wants to do
case $1 in

	setup)
		SetupDocker
		;;

	deploy)
		echo "Starting the front page ..."
		cd snkstream && cd web-server && cargo run
		ret=$?
		if [[ $ret -ne 0 && $ret -ne 1 ]]
		then
			echo "Failed to start front page"
		else
			echo "Done."
			
			echo ""

			echo "Starting all services ..."
			docker-compose up -d
			
			if [ $? -ne 0 ]
			then
				echo "Failed to start all services."
			else
				echo "Done."
			fi
		fi
		;;

	*)
		printUsage
		;;
esac
