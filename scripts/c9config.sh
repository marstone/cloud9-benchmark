#!/bin/sh

# load balancer
BALANCER="192.168.202.170:1337"

# workers
WORKER[0]="192.168.202.90,4"
#WORKER[1]="11.80.87.10,10"

# byte code relative path, related to the samba root
TARGET="target/ifelse.bc"

# samba information
SAMBA_PATH=//192.168.202.170/workspace
SAMBA_USER=marstone
SAMBA_PASS=marst0ne

