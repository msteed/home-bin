#!/usr/bin/fish

cd /
mount /dev/sdb1 /mnt

rdiff-backup \
    --exclude /boot \
    --exclude /dev \
    --exclude /mnt \
    --exclude /proc \
    --exclude /run \
    --exclude /sys \
    --exclude /tmp \
    --exclude /var \
    --exclude '/**/lost+found' \
    --exclude '/home/*/.cache' \
    --exclude '/home/*/.config' \
    --exclude '/home/*/Downloads' \
    --exclude '/home/*/VirtualBox*' \
    / /mnt/(hostname)

umount /mnt
