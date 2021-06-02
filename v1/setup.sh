#! bin/bash

# Command: nohup bash setup.sh & (this bash script name shuold be setup.sh)

echo "#############################################################################################"
echo "#                                    Set Up GCP  VM Instances                               #"
echo "#############################################################################################"
echo ""

# Configurations
NO_OF_PROC_CORES=`nproc`
PYTHON_VERSION="3.8.2"
HOME="/home"


echo "Changing Permission /home Directory"
sudo chmod 777 /home
cd $HOME

mkdir tools
mkdir zdns_results
mkdir seed
mkdir seed_downloads
mkdir zdns_logs


echo ">> Updating Packages"
echo ""
sudo apt update > /dev/null

echo ">> Installing Build Essentials"
echo ""
sudo apt --assume-yes install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev > /dev/null

echo ">> ----------------------------------------------------------------------------------------"
echo ""

# Install Python
# echo ">> Installing Python $PYTHON_VERSION"
# echo ""

# curl -O https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tar.xz
# tar -xf Python-$PYTHON_VERSION.tar.xz > /dev/null
# cd Python-$PYTHON_VERSION
# ./configure --enable-optimizations
# make -j $NO_OF_PROC_CORES > /dev/null
# sudo make altinstall > /dev/null
# cd $HOME
# python3 --version

echo ">> ----------------------------------------------------------------------------------------"
echo ""

# Install GIT
echo ">> Installing GIT "
echo ""
sudo apt --assume-yes install git > /dev/null

echo "Installing WGET"
echo ""
sudo apt --assume-yes install wget > /dev/null

echo ">> ----------------------------------------------------------------------------------------"
echo ""

# Install ZDNS
echo "Installing ZDNS"
wget https://golang.org/dl/go1.15.4.linux-amd64.tar.gz > /dev/null
sudo tar -C /usr/local -xzf go1.15.4.linux-amd64.tar.gz > /dev/null
export PATH=$PATH:/usr/local/go/bin > /dev/null
go version

git clone https://github.com/zmap/zdns.git > /dev/null
cd zdns && cd zdns
go build > /dev/null
mv zdns /home/tools/ > /dev/null

cd $HOME

echo ">> ----------------------------------------------------------------------------------------"
echo ""

# Install Bzip2 / pBzip2
echo "Installing bzip2"
sudo apt --assume-yes install bzip2 > /dev/null
echo "Installing pbzip2"
sudo apt --assume-yes install pbzip2 > /dev/null

# Clean Unneccessary Directories - Installations
# rm Python-$PYTHON_VERSION.tar.xz
rm go1.15.4.linux-amd64.tar.gz > /dev/null

echo ""
echo "#############################################################################################"
echo "#                                           Set Up Done                                     #"
echo "#############################################################################################"
echo ""

