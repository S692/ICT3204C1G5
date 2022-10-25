#!/bin/bash
cat > /etc/init.d/startup_network << 'endmsg'
#!/bin/bash
### BEGIN INIT INFO
# Provides:          startup_network
# Required-Start: $network
# Required-Stop: $network
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
### END INIT INFO
# Source function library
. /etc/default/startup_network
case "$1" in start) echo "Running startup_network in start mode"
touch /var/lock/subsys/startup_network
echo "$0 start at $(date)" >> /home/resch/destination/startup_network.log
if [ ${VAR1} = "true" ]
then echo "Connected to CNC Server" >> /home/resch/destination/startup_network.log
fi
echo ;; stop)
echo "Running the startup_network script in stop mode"
echo "$0 stop at $(date)" >> /home/resch/destination/startup_network.log
echo "Usage: startup_network {start | stop}"
exit 1
esac
exit 0
endmsg
sudo chmod 755 /etc/init.d/startup_network
cat > /etc/default/startup_network << 'endmsg'
VAR1="true"
endmsg
sudo service startup_network start