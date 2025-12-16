#!/bin/sh

TGBOT_TOKEN=$1
PY_VERSION=$2
PROJECT_PARENT=/usr/local/etc
PROJECT_HOME=${PROJECT_PARENT}/palettizer
PROJECT_REPO_URL=https://github.com/acdhound/palettizer.git
cd $PROJECT_PARENT

if [[ -z "$PY_VERSION" ]]; then
  echo "Python version is not set!"
  exit 1
fi

if [[ -z "TGBOT_TOKEN" ]]; then
  echo "Telegram Bot token is not set!"
  exit 1
fi

echo "Killing existing python processes..."
sudo killall python3
sudo killall python
sleep 5

PY_CMD=python$PY_VERSION
echo "Installing Python: $PY_CMD"
sudo yum -y install $PY_CMD

echo "Installing Pip: ${PY_CMD}-pip"
sudo yum -y install $PY_CMD-pip

echo "Installing Virtualenv"
sudo $PY_CMD -m pip install virtualenv

echo "Installing Git"
sudo yum -y install git

echo "Cloning the project into $PROJECT_HOME..."
if [ -e $PROJECT_HOME ]; then
  echo "Project root directory already exists, deleting: $PROJECT_HOME"
  sudo rm -r $PROJECT_HOME;
fi
sudo chmod o+w $PROJECT_PARENT
git clone $PROJECT_REPO_URL $PROJECT_HOME

cd $PROJECT_HOME

echo "Initializing a virtual env..."
$PY_CMD -m virtualenv venv
. ./venv/bin/activate

echo "Building the project..."
pip install .

echo "Starting the Telegram bot..."
(python -m palettizerbot $TGBOT_TOKEN > /dev/null 2> /dev/null) &

echo "Installation finished successfully"
