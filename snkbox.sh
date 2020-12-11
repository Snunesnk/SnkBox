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

#Function to install a software, based on its URL => don't know if it's a good method but ...
InstallSoft() {

}

#This function will get all setup for you.
#It will download all, add all repo, setup everything properly
#True magic
bigFunctionToInitAll()
{
	echo "Let's setup everything!"
	echo ""
	echo "--------------- FIRST PART: tools ---------------"
	echo ""
	echo "All the needed programm will be downloaded, such as wget, tar, ..."
	echo "Please make sure you have root access to download them, or that everything needed is already download."
	echo ""
	echo "Checking for wget ..."
	InstallAptPack "wgiet"
	

	echo ""
	echo "--------------- SECOND PART: softwares ---------------"
	echo ""
	echo "Now comes the great part."
	echo "All the softwares required for your webserver will be downloaded."
	echo "At certain point, you will be asked to choose between two softwares, or for a specific version of the software."
	echo "If you don't know which one to choose, go for the defaut option."
	echo ""
	echo "$boldDOCKER:$normal" #need to see if I have to switch to kubernetes
	
	echo ""
	echo "$boldTRANSMISSION:$normal"
	echo ""
	InstallSoft ""

}


#Let's find what the user wants to do
case $1 in

	init)
		bigFunctionToInitAll
		;;

	deploy)
		echo "I need to deploy all / some services"
		;;

	stop)
		echo "I need to stop all / some services"
		;;

	*)
		printUsage
		;;
esac
