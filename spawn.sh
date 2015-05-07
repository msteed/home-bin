#!/usr/bin/bash

if [ $# -ne 1 ]; then
    echo "usage: $(basename $0) machine-name"
    exit 1
fi

machinedir=$HOME/machines/$1

if [ ! -d $machinedir ]; then
    echo "$machinedir not found"
    exit 1
fi

hostshared=$HOME/shared
machshared=$machinedir/mnt/shared

sudo umount $machshared
sudo mount -o bind $hostshared $machshared
sudo systemd-nspawn --directory=$machinedir --boot --network-veth
