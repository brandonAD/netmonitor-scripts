#!/bin/bash

################################################
#Written by: Brandon A. Dwyer
#Implemented by: Alexander J. Kaczmarek
#script.sh
#
#The variables contained within are values
#obtained from ipTables' counters. A grep was run
#on a string that uniquely identifies the line
#with the desired counters. Additional filtration
#is used to single out the values using delimited
#fields.
#
#Two variables for each User Defined Chain. One
#for each counter value: Packets and Bytes
#
#After obtaining the figures, they are echoed to
#a file with a date stamp. These are the files
#that are ultimately sent to CloudWatch.
#
################################################

sshInPACKETS=`iptables -nvx -L sshIn --line-numbers | grep "sshBytes" | tr ' ' ',' | tr -s ',' | cut -f 2 -d ','`

sshInBYTES=`iptables -nvx -L sshIn --line-numbers | grep "sshBytes" | tr ' ' ',' | tr -s ',' | cut -f 3 -d ','`

sshOutPACKETS=`iptables -nvx -L sshOut --line-numbers | grep "sshBytes" | tr ' ' ',' | tr -s ',' | cut -f 2 -d ','`

sshOutBYTES=`iptables -nvx -L sshOut --line-numbers | grep "sshBytes" | tr ' ' ',' | tr -s ',' | cut -f 3 -d ','`

tcpInPACKETS=`iptables -nvx -L tcpIn --line-numbers | grep "tcpBytes" | tr ' ' ',' | tr -s ',' | cut -f 2 -d ','`

tcpInBYTES=`iptables -nvx -L tcpIn --line-numbers | grep "tcpBytes" | tr ' ' ',' | tr -s ',' | cut -f 3 -d ','`

tcpOutPACKETS=`iptables -nvx -L tcpOut --line-numbers | grep "tcpBytes" | tr ' ' ',' | tr -s ',' | cut -f 2 -d ','`

tcpOutBYTES=`iptables -nvx -L tcpOut --line-numbers | grep "tcpBytes" | tr ' ' ',' | tr -s ',' | cut -f 3 -d ','`

udpInPACKETS=`iptables -nvx -L udpIn --line-numbers | grep "udpBytes" | tr ' ' ',' | tr -s ',' | cut -f 2 -d ','`

udpInBYTES=`iptables -nvx -L udpIn --line-numbers | grep "udpBytes" | tr ' ' ',' | tr -s ',' | cut -f 3 -d ','`

udpOutPACKETS=`iptables -nvx -L udpOut --line-numbers | grep "udpBytes" | tr ' ' ',' | tr -s ',' | cut -f 2 -d ','`

udpOutBYTES=`iptables -nvx -L udpOut --line-numbers | grep "udpBytes" | tr ' ' ',' | tr -s ',' | cut -f 3 -d ','`

sshPACKETS=`iptables -nvx -L sshBytes --line-numbers | grep "tcpBytes" | tr ' ' ',' | tr -s ',' | cut -f 2 -d ','`

sshBYTES=`iptables -nvx -L sshBytes --line-numbers | grep "tcpBytes" | tr ' ' ',' | tr -s ',' | cut -f 3 -d ','`

tcpPACKETS=`iptables -nvx -L tcpBytes --line-numbers | grep "allBytes" | tr ' ' ',' | tr -s ',' | cut -f 2 -d ','`

tcpBYTES=`iptables -nvx -L tcpBytes --line-numbers | grep "allBytes" | tr ' ' ',' | tr -s ',' | cut -f 3 -d ','`

udpPACKETS=`iptables -nvx -L udpBytes --line-numbers | grep "allBytes" | tr ' ' ',' | tr -s ',' | cut -f 2 -d ','`

udpBYTES=`iptables -nvx -L udpBytes --line-numbers | grep "allBytes" | tr ' ' ',' | tr -s ',' | cut -f 3 -d ','`

inboundPACKETS=`iptables -nvx -L INPUT --line-numbers | grep "inputBytes" | tr ' ' ',' | tr -s ',' | cut -f 2 -d ','`

inboundBYTES=`iptables -nvx -L INPUT --line-numbers | grep "inputBytes" | tr ' ' ',' | tr -s ',' | cut -f 3 -d ','`

outboundPACKETS=`iptables -nvx -L OUTPUT --line-numbers | grep "outputBytes" | tr ' ' ',' | tr -s ',' | cut -f 2 -d ','`

outboundBYTES=`iptables -nvx -L OUTPUT --line-numbers | grep "outputBytes" | tr ' ' ',' | tr -s ',' | cut -f 3 -d ','`

totalPACKETS=`iptables -nvx -L allBytes --line-numbers | grep "\-\-" | tr ' ' ',' | tr -s ',' | cut -f 2 -d ','`

totalBYTES=`iptables -nvx -L allBytes --line-numbers | grep "\-\-" | tr ' ' ',' | tr -s ',' | cut -f 3 -d ','`

#These echo statements are the logged values being written to files
echo $(date) " [INBOUND SSH] Inbound SSH Packets: " ${sshInPACKETS} "Inbound SSH Bytes: " ${sshInBYTES} >> /var/log/AWSsshIn
echo $(date) " [OUTBOUND SSH] Outbound SSH Packets: " ${sshOutPACKETS} "Outbound SSH Bytes: " ${sshOutBYTES} >> /var/log/AWSsshOut
echo $(date) " [INBOUND TCP] Inbound TCP Packets: " ${tcpInPACKETS} "Inbound TCP Bytes: " ${tcpInBYTES} >> /var/log/AWStcpIn
echo $(date) " [OUTBOUND TCP] Outbound TCP Packets: " ${tcpOutPACKETS} "Outbound TCP Bytes: " ${tcpOutBYTES} >> /var/log/AWStcpOut
echo $(date) " [INBOUND UDP] Inbound UDP Packets: " ${udpInPACKETS} "Inbound UDP Bytes: " ${udpInBYTES} >> /var/log/AWSudpIn
echo $(date) " [OUTBOUND UDP] Outbound UDP Packets: " ${udpOutPACKETS} "Outbound UDP Bytes: " ${udpOutBYTES} >> /var/log/AWSudpOut
echo $(date) " [TOTAL SSH] Total SSH Packets: " ${sshPACKETS} "Total SSH Bytes: " ${sshBYTES} >> /var/log/AWStotalSSH
echo $(date) " [TOTAL TCP] Total TCP Packets: " ${tcpPACKETS} "Total TCP Bytes: " ${tcpBYTES} >> /var/log/AWStotalTCP
echo $(date) " [TOTAL UDP] Total UDP Packets: " ${udpPACKETS} "Total UDP Bytes: " ${udpBYTES} >> /var/log/AWStotalUDP
echo $(date) " [TOTAL INBOUND] Total Inbound Packets: " ${inboundPACKETS} "Total Inbound Bytes: " ${inboundBYTES} >> /var/log/AWStotalInbound
echo $(date) " [TOTAL OUTBOUND] Total Outbound Packets: " ${outboundPACKETS} "Total Outbound Bytes: " ${outboundBYTES} >> /var/log/AWStotalOutbound
echo $(date) " [TOTAL BI-DIRECTIONAL] Total Packets: " ${totalPACKETS} "Total Bytes: " ${totalBYTES} >> /var/log/AWSTOTAL
