# Other

sudo apt update && sudo apt upgrade -y 
sudo apt install neovim nano mc htop tmux docker.io tty-clock -y

echo "set -g mouse on" > ~/.tmux.conf


### Create Docker Network

docker network create openvpn-net-1
docker network create openvpn-net-2

### Get docker dockerfile
git clone https://github.com/astroreeko/dkr-sshd-openvpn.gi
cd dkr-sshd-openvpn
chmod +x entrypoint.sh


### Build Docker Image openvpnGate
docker build . -t openvpn-gate


### Run docker image
docker run --rm --name openvpn-1 --network openvpn-net-1 -dit --cap-add=NET_ADMIN --device /dev/net/tun --publish=8022:22 --env ROOT_PASSWORD=rico22 openvpn-gate


### Login into docker
docker exec -u root -t -i container_id /bin/bash

sudo openvpn --config /etc/openvpn/udp/NCVPN-AU-Melbourne-UDP.ovpn --daemon 



### Build Docker Image Outline


apk add nodejs-current=18 --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main --allow-untrusted
apk add npm
