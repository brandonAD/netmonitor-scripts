#!/bin/bash

################################################
#Written by: Brandon A. Dwyer
#resetLogging.sh
#
#This script is the workhorse of the logging. It
#will begin by stopping the startBytes.sh script,
#deleting the current log files and deleting the
#AWS Cloudwatch log groups and streams.
#
#It will then recreate the log group and streams,
#restart the AWS logging service and start the
#startBytes.sh script for packet and byte logging.
#
################################################

/bin/bash /home/ec2-user/monitoring/stopBytes.sh

/bin/bash /home/ec2-user/monitoring/resetFiles.sh

aws logs delete-log-stream --log-group-name management --log-stream-name MANAGEMENT-SSH_IN
aws logs delete-log-stream --log-group-name management --log-stream-name MANAGEMENT-SSH_OUT
aws logs delete-log-stream --log-group-name management --log-stream-name MANAGEMENT-TCP_IN
aws logs delete-log-stream --log-group-name management --log-stream-name MANAGEMENT-TCP_OUT
aws logs delete-log-stream --log-group-name management --log-stream-name MANAGEMENT-UDP_IN
aws logs delete-log-stream --log-group-name management --log-stream-name MANAGEMENT-UDP_OUT
aws logs delete-log-stream --log-group-name management --log-stream-name MANAGEMENT-SSH_TOTAL
aws logs delete-log-stream --log-group-name management --log-stream-name MANAGEMENT-TCP_TOTAL
aws logs delete-log-stream --log-group-name management --log-stream-name MANAGEMENT-UDP_TOTAL
aws logs delete-log-stream --log-group-name management --log-stream-name MANAGEMENT-TOTAL_INBOUND
aws logs delete-log-stream --log-group-name management --log-stream-name MANAGEMENT-TOTAL_OUTBOUND
aws logs delete-log-stream --log-group-name management --log-stream-name MANAGEMENT-TOTALBYTES
aws logs delete-log-group --log-group-name management

aws logs create-log-group --log-group-name management
aws logs create-log-stream --log-group-name management --log-stream-name MANAGEMENT-SSH_IN
aws logs create-log-stream --log-group-name management --log-stream-name MANAGEMENT-SSH_OUT
aws logs create-log-stream --log-group-name management --log-stream-name MANAGEMENT-TCP_IN
aws logs create-log-stream --log-group-name management --log-stream-name MANAGEMENT-TCP_OUT
aws logs create-log-stream --log-group-name management --log-stream-name MANAGEMENT-UDP_IN
aws logs create-log-stream --log-group-name management --log-stream-name MANAGEMENT-UDP_OUT
aws logs create-log-stream --log-group-name management --log-stream-name MANAGEMENT-SSH_TOTAL
aws logs create-log-stream --log-group-name management --log-stream-name MANAGEMENT-TCP_TOTAL
aws logs create-log-stream --log-group-name management --log-stream-name MANAGEMENT-UDP_TOTAL
aws logs create-log-stream --log-group-name management --log-stream-name MANAGEMENT-TOTAL_INBOUND
aws logs create-log-stream --log-group-name management --log-stream-name MANAGEMENT-TOTAL_OUTBOUND
aws logs create-log-stream --log-group-name management --log-stream-name MANAGEMENT-TOTALBYTES

sudo service awslogs restart

/bin/bash /home/ec2-user/monitoring/startBytes.sh &
