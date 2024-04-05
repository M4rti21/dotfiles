#!/bin/bash

## check if time of the day is night (between 9pm and 8am)
if [ $(date +%H) -ge 20 ] || [ $(date +%H) -lt 8 ]
then 
    source ./night.sh
else
    source ./day.sh
fi
