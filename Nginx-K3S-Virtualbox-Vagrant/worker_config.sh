apt update -y
apt install sshpass
sshpass -p vagrant scp -o StrictHostKeyChecking=no vagrant@192.168.123.100:/home/vagrant/token /home/vagrant/token
echo "192.168.123.100 Master" >> /etc/hosts
echo "192.168.123.111 Worker1" >> /etc/hosts
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent --server https://Master:6443 --token-file /home/vagrant/token --node-ip=192.168.123.111" sh -
