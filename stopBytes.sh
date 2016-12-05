#!/bin/bash

################################################
#Written by: Brandon A. Dwyer
#stopBytes.sh
#
#This script terminates the logging started by
#startBytes.sh by creating a file in the location
#that is checked for the while loop to continue.
#
#This file is subsequently deleted so that the
#startBytes.sh script can be run again.
#
################################################

touch /tmp/stop
sleep 5
rm /tmp/stop
