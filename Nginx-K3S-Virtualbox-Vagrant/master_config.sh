apt update -y
echo "192.168.123.100 Master" >> /etc/hosts
echo "192.168.123.111 Worker1" >> /etc/hosts
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --cluster-init --tls-san 192.168.123.100 --bind-address=192.168.123.100 --advertise-address=192.168.123.100 --node-ip=192.168.123.100 --write-kubeconfig-mode 644 --no-deploy=traefik" sh -
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config    
systemctl restart sshd.service
cat /var/lib/rancher/k3s/server/node-token > /home/vagrant/token

