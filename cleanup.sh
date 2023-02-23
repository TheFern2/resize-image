#!/bin/bash

lsblk | grep _mnt | while read -r line ; do
    n_loop=$(echo "$line" | awk '{print $1}')
    n_loop_mountpoint=$(echo "$line" | awk '{print $7}')
    umount "$n_loop_mountpoint"
    losetup -d /dev/"$n_loop"
done

if [ -f resize.img ]; then
    rm resize.img
fi

rm -r /tmp/resized_mnt/
rm -r /tmp/original_mnt/

