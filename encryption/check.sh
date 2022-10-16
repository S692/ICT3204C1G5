#!/bin/bash


# Check if Python3 is installed
if [!hash python3 2>/dev/null]
then
	echo "Python3 not installed."
	echo "Installing Python3..."
	apt-get install -y python3
else
	echo "Python3 is already installed."
fi


# Check if pip3 is installed
if [!hash pip3 2>/dev/null]
then
	echo "pip3 is not installed."
	echo "Installing pip3..."
	apt-get install -y python3-pip3
else
	echo "pip3 is already installed."
fi

# Install python modules
# Change the directory accordingly
pip3 install -r /vagrant/encryption/requirements.txt



