#!/bin/bash

# Manual commands
# cd /root && wget https://raw.githubusercontent.com/S692/ossas/main/exfiltration_attk.sh && chmod +x exfiltration_attk.sh
# ./exfiltration.sh

# Create the folder to store the exfiltrated files
mkdir -p /home/vagrant/exfiltrated
chown vagrant:vagrant /home/vagrant/exfiltrated