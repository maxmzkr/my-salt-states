sudo apt-get install python-software-properties -y
sudo add-apt-repository ppa:saltstack/salt -y

sudo apt-get update -y
sudo apt-get install xclip -y
sudo apt-get install salt-master -y
sudo apt-get install salt-minion -y
sudo apt-get install salt-syndic -y
sudo apt-get install pcregrep -y

hostString="127.0.0.1\tsalt"
if grep "$(echo -ne ${hostString})" /etc/hosts
then
	echo 'host file already setup'
else
	sudo echo -ne "${hostString}" | sudo tee --append /etc/hosts
fi

rootString="file_roots:\n  base:\n    - /home/max/my-salt-states\n"
if pcregrep -M "$(echo -ne ${rootString})" /etc/salt/master
then
	echo 'master file already setup'
else
	sudo echo -ne "${rootString}" | sudo tee --append /etc/salt/master
fi

rootString="file_roots:\n  base:\n    - /home/max/my-salt-states\n"
if pcregrep -M "$(echo -ne ${rootString})" /etc/salt/minion
then
	echo 'minion file already setup'
else
	sudo echo -ne "${rootString}" | sudo tee /etc/salt/minion
fi

# Setup github key
if [[ ! -e /home/max/.ssh/github ]]; then
	ssh-keygen -f /home/max/.ssh/github -N ""
fi
chmod 600 /home/max/.ssh/github
ssh-add /home/max/.ssh/github
cat /home/max/.ssh/github.pub | xclip -selection clipboard
read -p "Press any key after adding ssh key to github" anyKey

# Setup salt key
if [[ ! -e /home/max/.ssh/salt ]]; then
	ssh-keygen -f /home/max/.ssh/salt -N ""
fi
chmod 600 /home/max/.ssh/salt
ssh-add /home/max/.ssh/salt
sudo salt-call state.highstate
sudo salt-key -A -y

sudo service salt-master restart
sudo service salt-minion restart
