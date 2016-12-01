#!/bin/bash

sudo apt-get update

apt install -y git


touch $HOME/.git_trusted_certs.pem
for server in git.tcpcloud.eu github.com; do
    ex +'/BEGIN CERTIFICATE/,/END CERTIFICATE/p' \
    <(echo | openssl s_client -showcerts -connect $server:443) -scq \
    >> $HOME/.git_trusted_certs.pem
done
# verify certs signatures and configure git
git config --global http.sslCAInfo $HOME/.git_trusted_certs.pem

cat <<-EOF > salt.env 
export FORMULA_SOURCE=pkg
# change RECLASS_ADDRESS if you have already created a model.
#export RECLASS_ADDRESS=https://github.com/Mirantis/qa-mk20-salt-model
export SALT_MASTER=10.10.10.200
export DOMAIN=local.cloud
export APT_REPOSITORY_TAGS="main extra tcp tcp-salt"
EOF


curl -skL "https://raw.githubusercontent.com/tcpcloud/salt-bootstrap-test/master/bootstrap.sh" > bootstrap.sh
chmod +x ./bootstrap.sh

source *.env
SALT_MASTER=10.10.10.200 MINION_ID=cfg01.local.cloud ./bootstrap.sh master
