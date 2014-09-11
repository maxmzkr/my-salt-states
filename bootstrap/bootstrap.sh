sudo apt-get install python-software-properties -y
sudo add-apt-repository ppa:saltstack/salt -y

sudo apt-get update -y
sudo apt-get install salt-master -y
sudo apt-get install salt-minion -y
sudo apt-get install salt-syndic -y
sudo apt-get install pcregrep -y

hostString="127.0.0.1\tsalt"
if sudo grep "$(echo -ne ${hostString})" /etc/hosts
then
	echo 'host file already setup'
else
	sudo echo -e '127.0.0.1\tsalt' >> /etc/hosts
fi

rootString="file_roots:\n  base:\n    - /home/max/my-salt-states\n"
if sudo pcregrep -M "$(echo -ne ${rootString})" /etc/salt/master
then
	echo 'master file already setup'
else
	sudo echo -ne "${rootString}" >> /etc/salt/master
fi

rootString="file_roots:\n  base:\n    - /home/max/my-salt-states\n"
if sudo pcregrep -M "$(echo -ne ${rootString})" /etc/salt/minion
then
	echo 'minion file already setup'
else
	sudo echo -ne "${rootString}" >> /etc/salt/minion
fi

sudo salt-call state.highstate
sudo salt-key -A -y
