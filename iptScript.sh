#!/bin/bash

################################################
#Written by: Brandon A. Dwyer
#iptScript.sh
#
#This ipTables script is used only for logging
#traffic volume. All packets pass through the
#filters unmodified and no actions are taken based
#on packet contents or origin.
#
#Packet filtration is handled by the AWS security
#groups and rules configured outside of the EC2
#instance.
#
#Previous ipTables configurations will be flushed
#and any pre-existing User Defined Chains (UDC)
#will be deleted.
#
#The script will then create all of the necessary
#UDCs and chain rules to enable accurate traffic
#accounting.
#
################################################

#Flush iptables and delete non-default chains

iptables -F
iptables -Z
iptables -X

myIP="10.0.1.8"

#User Defined Chain Creation

iptables -N allBytes
iptables -N inputBytes
iptables -N outputBytes
iptables -N sshBytes
iptables -N sshIn
iptables -N sshOut
iptables -N tcpBytes
iptables -N tcpIn
iptables -N tcpOut
iptables -N udpBytes
iptables -N udpIn
iptables -N udpOut

#The allBytes chain tracks total interface bytes, inbound and outbound

iptables -A allBytes -s 0.0.0.0/0 #match anything and everything

#The inputBytes and outputBytes chains will allow tracking bytes by direction

iptables -A inputBytes -p tcp -d $myIP -j tcpIn #tcp traffic is sent to the tcp chain
iptables -A inputBytes -p udp -d $myIP -j udpIn #udp traffic is sent to the udp chain

iptables -A outputBytes -p tcp -s $myIP -j tcpOut #tcp traffic is sent to the tcp chain
iptables -A outputBytes -p udp -s $myIP -j udpOut #udp traffic is sent to the udp chain

#Input and Output on a per-protocol basis

#All SSH traffic is TCP traffic so the following 4 rules filters between ssh and pure TCP traffic

iptables -A tcpIn -s 0.0.0.0/0 -p tcp --dport 22 -j sshIn #if ssh traffic, send to sshIn
iptables -A tcpIn -s 0.0.0.0/0 -j tcpBytes #send all other inbound tcp traffic to tcpBytes
iptables -A tcpOut -s 0.0.0.0/0 -p tcp --sport 22 -j sshOut #if ssh traffic, send to sshOut
iptables -A tcpOut -s 0.0.0.0/0 -j tcpBytes #send all other outbound tcp traffic to tcpBytes

iptables -A sshIn -s 0.0.0.0/0 -j sshBytes #record packets/bytes and send to sshBytes
iptables -A sshOut -s 0.0.0.0/0 -j sshBytes #record packets/bytes and send to sshBytes

iptables -A udpIn -s 0.0.0.0/0 -j udpBytes #record packets/bytes and send to udpBytes
iptables -A udpOut -s 0.0.0.0/0 -j udpBytes #record packets/bytes and send to udpBytes

#Inbound and Outbound traffic

iptables -A sshBytes -s 0.0.0.0/0  #record packets/bytes
#Note that the sshBytes chain does not jump to the totalBytes chain. This
#is because the ssh traffic also matches the second tcpIn rule so it is
#already recorded once

#All types of traffic will ultimately be recorded in the "allBytes" chain

iptables -A tcpBytes -s 0.0.0.0/0 -j allBytes #record packets/bytes and send to allBytes
iptables -A udpBytes -s 0.0.0.0/0 -j allBytes #record packets/bytes and send to allBytes

#Recording traffic by direction

iptables -A INPUT -d $myIP -j inputBytes
iptables -A OUTPUT -s $myIP -j outputBytes
