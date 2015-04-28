#!/bin/bash

width=128
spaces="                                                                                                                        "

while true; do
    uptime="$(uptime | cut -f3- -d' ')"
    memval=( $(grep -e 'MemTotal' -e 'MemFree' /proc/meminfo | tr -s ' ' | cut -f2 -d' ') )
    memfree=$(( 100 * ${memval[1]} / ${memval[0]} ))
    center="${uptime},  mem: ${memfree}% free"
    cspaces=$((width/2 - ${#center}/2))
    right="$(acpi -b)      $($HOME/bin/timer -e)"
    rspaces=$((width - ${#cspaces} - ${#center} - ${#right}))
    echo "${spaces:0:$cspaces}${center}${spaces:0:rspaces}${right}"
    sleep 10
done
