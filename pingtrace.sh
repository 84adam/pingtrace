#!/bin/bash

if [ ! "`whoami`" = "root" ]
then
    echo "This script must be run as root. Exiting..."
    exit 1
fi

# IFCONFIG

echo "Gathering interface and IP information..."
printf "IFCONFIG OUTPUT: \n\n" >> pingtrace.out

ifconfig -a | tee -a pingtrace.out
printf "\n---\n\n" >> pingtrace.out

# PING

echo "Running ping tests..."
printf "PING TEST RESULTS: \n\n" >> pingtrace.out

ping -c 3 archive.ubuntu.com | tee -a pingtrace.out
printf "\n---\n\n" >> pingtrace.out
ping -c 3 security.ubuntu.com | tee -a pingtrace.out
printf "\n---\n\n" >> pingtrace.out
ping -c 3 google.com | tee -a pingtrace.out
printf "\n---\n\n" >> pingtrace.out

# TRACEROUTE

echo "Running traceroute tests..."
printf "TRACEROUTE TEST RESULTS: \n\n" >> pingtrace.out

traceroute google.com | tee -a pingtrace.out
printf "\n---\n\n" >> pingtrace.out
printf "Checking with traceroute -I, using ICMP ECHO for probes...\n\n" | tee -a pingtrace.out
traceroute -I google.com | tee -a pingtrace.out
printf "\n---\n\n" >> pingtrace.out
traceroute security.ubuntu.com | tee -a pingtrace.out
printf "\n---\n\n" >> pingtrace.out
printf "Checking with traceroute -I, using ICMP ECHO for probes...\n\n" | tee -a pingtrace.out
traceroute -I security.ubuntu.com | tee -a pingtrace.out
printf "\n---\n\n" >> pingtrace.out
traceroute archive.ubuntu.com | tee -a pingtrace.out
printf "\n---\n\n" >> pingtrace.out
printf "Checking with traceroute -I, using ICMP ECHO for probes...\n\n" | tee -a pingtrace.out
traceroute -I archive.ubuntu.com | tee -a pingtrace.out
printf "\n---\n\n" >> pingtrace.out

echo "TESTS COMPLETE. PLEASE REVIEW THE LOG FILE: pingtrace.log"
