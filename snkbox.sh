#!/usr/bin/env bash

# Automated deployment of automated media server (insn't it beautiful ?)
# During the deployment process, you can choose between a local installation,
# and remote installation with reverse proxy to your own domain name.
# you will be asked to make several choices. If you don't know the answer -> go for
# the defaut choice.
# You will be asked for several cretidentials too, please make sure you've prepared them
# Everything will be kept locally

# Determine if the script is launched with init, deploy or stop

# Fonction to print usage if user used an invalid option / no option
printUsage()
{
	echo "I'll print the usage";
}


#This function will get all setup for you.
#It will download all, add all repo, setup everything properly
#True magic
bigFunctionToInitAll()
{
	echo "Let's init everything!";
}

if [ -z $1 ]
then
	printUsage

elif [ $1 == "init" ]
then
	echo "It works!";
fi


