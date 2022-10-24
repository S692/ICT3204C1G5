#!/bin/bash

echo ">>>>  Right before SG initialization <<<<"
# use while loop to check if elasticsearch is running 
while true
do
    if [ps -A | grep -i elasticsearch]
		echo "Starting metricbeat"
            metricbeat setup -e
			service metricbeat start
            break
    else
        echo "ES is not running yet"
        sleep 5
    fi
done

 