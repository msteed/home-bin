#!/usr/bin/fish

mount /dev/sdb1 /mnt

rdiff-backup \
    --exclude /boot \
    --exclude /dev \
    --exclude '/**/lost+found' \
    --exclude /mnt \
    --exclude /proc \
    --exclude /run \
    --exclude /sys \
    --exclude /var \
    --exclude '/home/*/.cache' \
    --exclude '/home/*/.config' \
    --exclude '/home/*/Downloads' \
    --exclude '/home/*/VirtualBox*' \
    / /mnt/(hostname)

umount /mnt
