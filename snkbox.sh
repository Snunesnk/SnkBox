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


# Determine if the script is launched with init, deploy or stop

# Fonction to print usage if user used an invalid option / no option
printUsage()
{
	echo "I'll print the usage"
}


#Function to install package with apt
InstallAptPack() {
	#Check if a file would be executed when calling "wget", and check that it's
	#an existing pass
	if ! pack_location=$(type -p $1) || [[ -z $pack_location ]];
	then
		echo "$1 not installed, installing it ..."
		sudo apt install $1
		
		#Check if everything went well
		ret_val=$?

		echo "$ret_val"

		if [ $ret_val -eq 0 ]
		then
			echo "$1 installed successfully !" #Maybe I can add little coloration to this
		else
			echo "Intallation for $bold$1$normal failed ..."
			echo "Try to fix the error or install $1 manually, then you may relaunch the script."
			exit 1
		fi
	else
		echo "$1 already installed, skip installation."
	fi
}

##Function to install a software, based on its URL => don't know if it's a good method but ...
#InstallSoft() {
#
#}

#This function will get all setup for you.
#It will download all, add all repo, setup everything properly
#True magic
bigFunctionToInitAll()
{
	echo "Let's setup everything!"
	echo ""
	echo "${bold}--------------- FIRST PART: tools ---------------${normal}"
	echo ""
	echo "All the needed programm will be downloaded, such as wget, tar, ..."
	echo "Please make sure you have root access to download them, or that everything needed is already download."
	echo ""
	echo "Checking for wget ..."
	InstallAptPack "wget"

	echo ""
	echo "${bold}--------------- SECOND PART: softwares ---------------${normal}"
	echo ""
	echo "Now comes the great part."
	echo "All the softwares required for your webserver will be downloaded."
	echo "At certain point, you will be asked to choose between two softwares, or for a specific version of the software."
	echo "If you don't know which one to choose, go for the defaut option."
	echo ""



	echo "${bold}DOCKER:${normal}" #need to see if I have to switch to kubernetes
	echo ""
	echo "Removing old docker versions (if any) ..."
	sudo apt remove docker docker-engine docker.io containerd runc
	echo "Done."
	echo "Updating ..."
	sudo apt update
	echo "Done."
	echo "Instaling everything needed."
	sudo apt install apt-transport-https \
		ca-certificates \
		curl \
		gnupg-agent \
		software-properties-common
	echo "Done."
	echo "Adding Docker's official GPG key ..."
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	echo "Done."
	echo "Setting up stabel repository ..."
	sudo add-apt-repository \
		"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
		$(lsb_release -cs) \
		stable"
	echo "Done."
	echo "Updating repo ..."
	sudo apt update
	echo "Done."
	echo "Installing docker engine ..."
	sudo apt install docker-ce docker-ce-cli containerd.io
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
	echo "${bold}Portainer:${normal}"
	echo ""
	echo "Creating volume for portainer."
	sudo docker volume create portainer_data
	echo "Done."



	echo ""
	echo "${bold}TRANSMISSION:${normal}"
	echo ""
#	InstallSoft ""

}


#Start one or more services by executing the corresponding script
deployServices() {
	#Check if user specified a service, if not then launch all scripts
	if [ -z $2 ]
	then
		for script in ./deploy_scripts/
		do
			bash script
		done
	else
		for service in $@
		do
			if [ $service != "deploy" ]
			then
				sudo bash ./deploy_scripts/${service}_deploy.sh
				if [ $? -ne 0 ]
				then
					echo "An error occured when trying to deploy $service."
					echo "Please check the spelling, it must match ./deploy_scripts/<service>_deploy.sh"
					echo "Aborting."
					exit
				fi
			fi
		done
	fi
}

#Let's find what the user wants to do
case $1 in

	init)
		bigFunctionToInitAll
		;;

	deploy)
		deployServices "$@"
		;;

	stop)
		echo "I need to stop all / some services"
		;;

	*)
		printUsage
		;;
esac
