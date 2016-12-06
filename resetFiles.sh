#!/bin/bash

################################################
#Written by: Brandon A. Dwyer
#Implemented by: Alexander J. Kaczmarek
#resetFiles.sh
#
#This script deletes all log files created by
#script.sh.
#
#CloudWatch logging will not properly reset
#without file deletion (as opposed to clearing
#the contents.
#
################################################

rm -f /var/log/AWSsshIn
rm -f /var/log/AWSsshOut
rm -f /var/log/AWStcpIn
rm -f /var/log/AWStcpOut
rm -f /var/log/AWSudpIn
rm -f /var/log/AWSudpOut
rm -f /var/log/AWStotalSSH
rm -f /var/log/AWStotalTCP
rm -f /var/log/AWStotalUDP
rm -f /var/log/AWStotalInbound
rm -f /var/log/AWStotalOutbound
rm -f /var/log/AWSTOTAL
