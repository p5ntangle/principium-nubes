#!/bin/bash

sudo apt-get update

curl -skL "https://raw.githubusercontent.com/tcpcloud/salt-bootstrap-test/master/bootstrap.sh" > bootstrap.sh
chmod +x bootstrap.sh

# configures tcpcloud apt repo and install resources from packages
SALT_MASTER=10.10.10.200 MINION_ID=$1.local.cloud ./bootstrap.sh minion