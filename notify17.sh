#!/bin/bash

###############################################################################
# SENDS NOTIFICATION THROUGH NOTIFY17 WHEN UPDATES AVAILABLE.                 #
# (Needs API KEY from Notify17!)                                              #
# Version 1.0                                                                 #
# Target: RaspberryPi Zero W (Raspbian Buster)                                #
###############################################################################
# ****Usage:****                                                              #
# Request API KEY from Notify17 and place it in apiKey variable               #
# Add a title to title variable                                               #
# Add a message to message variable - output of apt-get can be added to the   #
#   message                                                                   #
# Place this file in cron.daily, cron.weekly etc. directory or install job    #
#   with cron/anacron                                                         #
###############################################################################
# ****This script was downloaded from:****                                    #
# https://www.fosslife.org/2-simple-steps-securing-your-linux-desktop         #
###############################################################################
# ****Based on:****                                                           #
# "Send an email when package updates are available so that you can manually  #
# check you want to update them.                                              #
# Author: Chris Binnie"                                                       #
###############################################################################
# ****Tool:****                                                               #
# VS Code 1.46.0                                                              #
# OS: Pop!_OS Linux x64 5.4.0-7634-generic                                    #
###############################################################################

# Global variable(s):
count=0
OUTPUT=""
apiKey="<YOUR API KEY>"
title="<YOUR TITLE>"
message="<YOUR MESSAGE>"


# Needs root!
apt-get update

# count = number of existence of "following" in output.
OUTPUT=$(apt-get -s full-upgrade)
count=$(grep -c "following" <<< "$OUTPUT")

# *Output of apt-get can be sent with message*
# message="$OUTPUT"

# Test for count and send notification.
if [ $count -gt 0 ]
    then
        curl -X POST "https://hook.notify17.net/api/raw/$apiKey" -F title="$title" -F content="$message"
else
    exit 0
fi
