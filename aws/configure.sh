#!/bin/sh

TGBOT_TOKEN=$1
PROJECT_PARENT=/usr/local/etc
PROJECT_HOME=${PROJECT_PARENT}/palettizer
PROJECT_REPO_URL=https://github.com/acdhound/palettizer.git
cd $PROJECT_PARENT

echo "Killing existing python processes..."
sudo killall python3
sleep 5

echo "Installing packages..."
sudo yum -y upgrade python3
sudo yum -y install pip
sudo yum -y install git

echo "Cloning the project into $PROJECT_HOME..."
if [ -e $PROJECT_HOME ]; then
  sudo rm -r $PROJECT_HOME;
fi
sudo git clone $PROJECT_REPO_URL $PROJECT_HOME

echo "Building the project..."
cd palettizer
sudo pip3 install .

echo "Starting the Telegram bot..."
sudo python3 -m palettizerbot $TGBOT_TOKEN &

echo "Installation finished successfully"
