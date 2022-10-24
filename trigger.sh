#!/bin/bash

echo ">>>>  Right before SG initialization <<<<"
# use while loop to check if elasticsearch is running 
while true
do
    netstat -uplnt | grep :9200 | grep LISTEN > /dev/null
    verifier=$?
    if [ 0 = $verifier ]
        then
            echo "Starting metricbeat"
            metricbeat setup -e
			service metricbeat start
            break
        else
            echo "ES is not running yet"
            sleep 5
    fi
done

 