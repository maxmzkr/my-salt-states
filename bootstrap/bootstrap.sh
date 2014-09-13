apt-get install python-software-properties -y
add-apt-repository ppa:saltstack/salt -y

apt-get update -y
apt-get install salt-master -y
apt-get install salt-minion -y
apt-get install salt-syndic -y
apt-get install pcregrep -y

hostString="10.0.0.9\tsalt"
if grep "$(echo -ne ${hostString})" /etc/hosts
then
	echo 'host file already setup'
else
	echo -e "${hostString}" >> /etc/hosts
fi

rootString="file_roots:\n  base:\n    - /home/max/my-salt-states\n"
if pcregrep -M "$(echo -ne ${rootString})" /etc/salt/master
then
	echo 'master file already setup'
else
	echo -ne "${rootString}" >> /etc/salt/master
fi

rootString="file_roots:\n  base:\n    - /home/max/my-salt-states\n"
if pcregrep -M "$(echo -ne ${rootString})" /etc/salt/minion
then
	echo 'minion file already setup'
else
	echo -ne "${rootString}" >> /etc/salt/minion
fi

keyString="$(ssh-keyscan -H 10.0.0.9)"
if [[ -z "${keyString}" ]]; then
	apt-get install openssh-server -y
	cp /etc/ssh/sshd_config /etc/ssh/sshd_config.factory-defaults
	chmod a-w /etc/ssh/sshd_config.factory-defaults
  keyString="$(ssh-keyscan -H 10.0.0.9)"
else
	echo "key was retrieved the first time"
fi

if [[ -z "${keyString}" ]]; then
	echo 'could not find the ssh server 10.0.0.9'
	exit 1
else
	echo "key was retrieved the second time"
fi

keyArr=()
echo "${keyString}" | while read -r line; do
	keyArr+=("${line}")
done

for key in "${keyArr[@]}"; do
	if [[ -z "$(grep \'"${key}"\' /home/max/.ssh/known_hosts)" ]]; then
		echo "${key}" >> /home/max/.ssh/known_hosts
	fi
done

if [[ ! -e /home/max/.ssh/synergy ]]; then
	ssh-keygen -f /home/max/.ssh/synergy -N ""
fi

if [[ ! -e /home/max/.ssh/salt ]]; then
	ssh-keygen -f /home/max/.ssh/salt -N ""
fi

chmod 600 /home/max/.ssh/synergy
chmod 600 /home/max/.ssh/salt

ssh-add /home/max/.ssh/synergy
ssh-add /home/max/.ssh/salt

cat /home/max/.ssh/synergy.pub /home/max/.ssh/salt.pub | ssh max@10.0.0.9 -o StrictHostKeyChecking=no "cat >> /home/max/.ssh/authorized_keys && exit"

salt-call state.highstate

ssh -t max@10.0.0.9 -i /home/max/.ssh/synergy "sudo salt-key -A -y && exit"
salt-key -A -y

service salt-master restart
service salt-minion restart
