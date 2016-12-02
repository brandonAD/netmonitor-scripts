#!/bin/bash

while ! test -f /tmp/stop
do /home/ec2-user/monitoring/script.sh &
sleep 5
done

