echo "deb [trusted=yes] http://zewo.github.io/apt ./" | sudo tee --append /etc/apt/sources.list
sudo apt-get update
sudo apt-get install libdill