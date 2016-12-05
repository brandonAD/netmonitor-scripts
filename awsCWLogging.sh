#!/bin/bash

################################################
#Written by: Brandon A. Dwyer
#awsCWLogging.sh
#
#This script is designed to be run at boot time
#using crontab. This runs the iptScript.sh to
#setup ipTables for packet and byte accounting.
#
#It will then run resetLogging.sh to setup the
#logging mechanisms to send log files to AWS.
#
################################################

#This script will completely reset iptables and AWS cloudwatch logging

/bin/bash /home/ec2-user/monitoring/iptScript.sh

sleep 5

/bin/bash /home/ec2-user/monitoring/resetLogging.sh
