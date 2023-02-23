p2_size isn't calculated properly
if the loop device is out of order

sudo losetup --find --partscan IMG-UC-8200_dump.img

```
~/g/w/tmp  sudo losetup --find --partscan IMG-UC-8200_dump.img
loop28        7:28   0   7.3G  0 loop
├─loop28p1  259:7    0    32M  0 part
├─loop28p2  259:8    0   478M  0 part
└─loop28p3  259:9    0   6.8G  0 part
~/g/w/tmp  fdisk -l IMG-UC-8200_dump.img
Disk IMG-UC-8200_dump.img: 7.29 GiB, 7820083200 bytes, 15273600 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xd188bc95

Device                Boot   Start      End  Sectors  Size Id Type
IMG-UC-8200_dump.img1 *       2048    67583    65536   32M 83 Linux
IMG-UC-8200_dump.img2        67584  1046527   978944  478M 83 Linux
IMG-UC-8200_dump.img3      1046528 15273599 14227072  6.8G 83 Linux

sudo losetup -d /dev/loop28
```

Testing mount-img

```
sudo ./mount-img mount ../tmp/IMG-UC-8200_dump.img ../tmp/mnt

 ~/g/w/tmp  sudo du -s -BM mnt/p1                                                    2269ms
7M      mnt/p1/
 ~/g/w/tmp  sudo du -s -BM mnt/p2
351M    mnt/p2
 ~/g/w/tmp  sudo du -s -BM mnt/p3
273M    mnt/p3
```

```
sudo ./mount-img mount resize.img ../tmp/mnt2
```

```
moxa@Moxa:~$ lsblk
NAME         MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda            8:0    1 14.4G  0 disk
└─sda1         8:1    1 14.4G  0 part
mtdblock0     31:0    0  1.5M  0 disk
mtdblock1     31:1    0  128K  0 disk
mtdblock2     31:2    0  128K  0 disk
mmcblk0      179:0    0 58.2G  0 disk
└─mmcblk0p1  179:1    0 58.2G  0 part
mmcblk2      179:8    0  7.3G  0 disk
├─mmcblk2p1  179:9    0   32M  0 part
├─mmcblk2p2  179:10   0  478M  0 part /
└─mmcblk2p3  179:11   0  400M  0 part /overlayfs
mmcblk2boot0 179:16   0    4M  1 disk
mmcblk2boot1 179:24   0    4M  1 disk
mmcblk2rpmb  179:32   0    4M  0 disk
```

| tee -a log.txt