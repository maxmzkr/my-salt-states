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
