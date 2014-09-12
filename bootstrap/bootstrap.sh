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

keyString="$(ssh-keyscan -H 10.0.0.9)"
if [[ -z "${keyString}" ]]; then
	sudo apt-get install openssh-server -y
	sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.factory-defaults
	sudo chmod a-w /etc/ssh/sshd_config.factory-defaults
  keyString="$(ssh-keyscan -H 10.0.0.9)"
fi

if [[ -z "${keyString}" ]]; then
	echo 'could not find the ssh server 10.0.0.9'
	exit 1
fi

echo "${keyString}"

if [[ -n "$(pcregrep -M "${keyString}" /home/max/.ssh/known_keys)" ]]; then
	echo 'key already in the know_keys file'
else
	echo "${keyString}" >> /home/max/.ssh/known_keys
fi

sudo salt-call state.highstate
sudo salt-key -A -y
