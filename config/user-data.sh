#!/bin/bash
# Install code-server
curl -fsSL https://code-server.dev/install.sh | sudo sh -s -- --version=${VERSION}

sleep 5

# Enable and start code-server for the user
systemctl enable --now code-server@${USER}
sleep 5

# Modify the code-server configuration
sed -i.bak 's/bind-addr: 127.0.0.1:8080/bind-addr: 0.0.0.0:8080/' /home/${USER}/.config/code-server/config.yaml

TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` \
&& INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id) \
&& sed -i.bak "s/^password: .*/password: $INSTANCE_ID/" /home/${USER}/.config/code-server/config.yaml
# Restart the service
sudo systemctl restart code-server@${USER}