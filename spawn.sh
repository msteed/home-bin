#!/usr/bin/bash

if [ $# -ne 1 ]; then
    echo "usage: $(basename $0) machine-name"
    exit 1
fi

machine=$1
machinedir=$HOME/machines/$machine

if [ ! -d $machinedir ]; then
    echo "$machinedir not found"
    exit 1
fi

hostshared=$HOME/shared
machshared=$machinedir/mnt/shared

update_hosts() {
    # Update /etc/hosts to reflect container host0 ip
    sleep 10
    addr=$(ssh root@$machine 'ip addr show dev host0' | grep -o 'inet 10\.0\.0\.[0-9]\+' | cut -f2 -d' ')
    if [ -n "$addr" ]; then
        hosts=$hostshared/etc/hosts
        sudo sed -i '/.*\<'$addr'\>.*/d' $hosts
        sudo sed -i '/.*\<'$machine'\>.*/d' $hosts
        sudo sh -c "echo \"$addr $machine\" >>$hosts"
    fi
}

sudo umount $machshared
sudo mount -o bind $hostshared $machshared
update_hosts &

sudo systemd-nspawn --directory=$machinedir --boot --network-veth

echo "unmounting $machshared"
sudo umount $machshared
