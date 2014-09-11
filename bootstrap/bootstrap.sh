sudo apt-get install python-software-properties -y
sudo add-apt-repository ppa:saltstack/salt -y

sudo apt-get update -y
sudo apt-get install salt-master -y
sudo apt-get install salt-minion -y
sudo apt-get install salt-syndic -y

sudo echo -e '127.0.0.1\tsalt' >> /etc/hosts
