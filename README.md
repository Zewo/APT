```sh
echo "deb [trusted=yes] http://apt.zewo.io ./" | sudo tee --append /etc/apt/sources.list
sudo apt-get update
sudo apt-get install zewo
```
