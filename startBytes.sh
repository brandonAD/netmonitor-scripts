#!/bin/bash

################################################
#Written by: Brandon A. Dwyer
#Implemented by: Alexander J. Kaczmarek
#startBytes.sh
#
#This script enables logging at a rate of 20 per
#minute (5 per second).
#
#A check is made at the beginning of the loop to
#see if a file exists in the specified location.
#If the file does not exist, a log will be made.
#To end the logging from this script, run the
#stopBytes.sh script.
#
################################################

while ! test -f /tmp/stop
do /home/ec2-user/monitoring/script.sh &
sleep 5
done

